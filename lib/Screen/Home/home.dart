import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onlinetv/Providers/app_provider.dart';
import 'package:onlinetv/Screen/Favorite/favorite.dart';
import 'package:onlinetv/Screen/Home/widget.dart';
import 'package:onlinetv/Screen/Youtube/youtubetest.dart';
import 'package:onlinetv/Model/model.dart';
import 'package:onlinetv/Service/service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constants/source_type.dart';
import '../IPTV/iptv_player.dart';

class Home extends StatelessWidget {
  List<ChannelModel>? channelData;
  Future<void> getData() async {
    NetworkService networkService = NetworkService();
    channelData = await networkService.getData();
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf8f4fd),
        appBar: AppBar(
          title: Text("OnlineTV"),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Consumer<AppProvider>(
                builder: (context, provider, child) {
                  return IconButton(
                    onPressed: () {
                      final myProvider =
                      Provider.of<AppProvider>(context, listen: false);
                      myProvider.getFav();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FavoriteScreen()));
                    },
                    icon: Icon(Icons.star,color: provider.favData == null ? Colors.amber : provider.favData!.length > 0 ? Colors.amber : Colors.grey,),
                  );
                },
              ),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data != null) {
                return GridView.builder(
                  itemCount: channelData!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0),
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          if (channelData![index].source == Source.iptv) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => IptvPlayer(
                                          iptvUrl: channelData![index].link,
                                          channelName:
                                              channelData![index].channelName,
                                          thumbnail:
                                              channelData![index].thumbnail,
                                        )));
                          } else if (channelData![index].source ==
                              Source.youtube) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => YoutubePlayer(
                                        youtubeLink: channelData![index].link,
                                        channelName:
                                            channelData![index].channelName,
                                        thumbnail:
                                            channelData![index].thumbnail)));
                          }
                        },
                        child: ItemHolder(
                          channelData: channelData,
                          index: index,
                        ),
                      ),
                    );
                  },
                );
              }
              return Text("INIT");
            },
          ),
        ));
  }
}
