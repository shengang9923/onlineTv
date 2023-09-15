import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/model.dart';

class AppProvider extends ChangeNotifier {
  List<ChannelModel>? _favData;
  List<ChannelModel> _tvlistData = [];
  List _clickFav = [];
  bool _itemSelected = false;

  List<ChannelModel>? get favData => _favData;
  List<ChannelModel> get tvlistData => _tvlistData;
  List get clickFav => _clickFav;

  bool get itemSelected => _itemSelected;

  setTvList(data){
    _tvlistData = data;
    notifyListeners();
  }

  setFav(favData, channel_name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (!sharedPreferences.containsKey("fav")) {
      List firstData = [];
      firstData.add(jsonDecode(favData));
      await sharedPreferences.setString("fav", jsonEncode(firstData));
      getFav();
    } else {
      final fares = sharedPreferences.getString("fav");
      final storedata = jsonDecode(fares.toString());

      bool exists = storedata
          .any((jsonObject) => jsonObject['channel_name'] == channel_name);
      if (exists) {
        getFav();
      } else {
        storedata.add(jsonDecode(favData));
        await sharedPreferences.setString("fav", jsonEncode(storedata));
        getFav();
      }

      //getFav();
    }
  }

  removeFav(id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final fares = sharedPreferences.getString("fav");
    final storedata = jsonDecode(fares.toString());
    storedata.removeWhere((element) => element['channel_name'] == "$id");
    await sharedPreferences.setString("fav", jsonEncode(storedata));
    getFav();
  }

  getFav() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (!sharedPreferences.containsKey("fav")) {
      _favData = channelModelFromJson("[]");
      notifyListeners();
    } else {
      dynamic fares = sharedPreferences.getString("fav");
      _clickFav = jsonDecode(fares == null ? "[]" : fares);
      _favData = channelModelFromJson(fares.toString());
      notifyListeners();
    }
  }

  //item select
  itemClick() {
    _itemSelected = true;
    notifyListeners();
  }
}
