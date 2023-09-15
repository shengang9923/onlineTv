import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:onlinetv/Model/model.dart';
import 'package:onlinetv/Providers/app_provider.dart';
import 'package:provider/provider.dart';

class NetworkService {
  final baseUrl =
      "https://flutterappsproject.000webhostapp.com/OTV/tvlist.json";

  Future<List<ChannelModel>> getData() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return channelModelFromJson(response.body);
    } else {
      // Handle HTTP error responses (e.g., 404, 500)
      // ...
      EasyLoading.showToast("Request Data Error");
      return channelModelFromJson("[]");
    }
  }
}
