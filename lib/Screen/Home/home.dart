import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onlinetv/Providers/app_provider.dart';
import 'package:onlinetv/Screen/Favorite/favorite.dart';
import 'package:onlinetv/Screen/Home/widget.dart';
import 'package:onlinetv/Screen/Youtube/youtubetest.dart';
import 'package:onlinetv/Model/model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constants/source_type.dart';
import '../IPTV/iptv_player.dart';

class Home extends StatelessWidget {
  String channelList = '''[
    {
      "channel_name": "ABC News",
      "link":
          "https://abc-iview-mediapackagestreams-2.akamaized.net/out/v1/6e1cc6d25ec0480ea099a5399d73bc4b/index.m3u8",
      "source": "iptv",
       "thumbnail" : "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/ABC_News_logo_2021.svg/1200px-ABC_News_logo_2021.svg.png"
    },
    {
      "channel_name": "Africanews",
      "link": "https://www.youtube.com/embed/NQjabLGdP5g?autoplay=1",
      "source": "youtube",
      "thumbnail" : "https://upload.wikimedia.org/wikipedia/commons/d/d3/Africanews._alternative_logo_2016.png"
    },
    {
    "channel_name": "Arirang",
      "link": "https://ythls.onrender.com/channel/UC-PHIZjV-oX8H7zD1cCN2NQ.m3u8",
      "source": "iptv",
      "thumbnail" : "https://yt3.googleusercontent.com/4PthwEL90ZIhkgYJXf2MB31m0TzindJ6f_j5frukEUTLtbnL2MHBD-CGDaV5_TRTdiJQMJJyAg=s900-c-k-c0x00ffffff-no-rj"
    },
    {
    "channel_name": "Channel News Asia",
      "link": "https://www.youtube.com/embed/XWq5kBlakcQ?autoplay=1",
      "source": "youtube",
      "thumbnail" : "https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/CNA_new_logo.svg/150px-CNA_new_logo.svg.png"
    }
  ]''';
  List<ChannelModel>? channelData;

  Future<void> getData() {
    channelData = channelModelFromJson(channelList.toString());
    return Future.value(false);
  }

  // List<Channel> channelList = [
  //   {
  //
  //   }
  //   Channel(channelName: "ABC News", link: "https://abc-iview-mediapackagestreams-2.akamaized.net/out/v1/6e1cc6d25ec0480ea099a5399d73bc4b/index.m3u8", source: Source.iptv),
  //   Channel(channelName: "Africanews", link: "https://www.youtube.com/embed/NQjabLGdP5g?autoplay=1", source: Source.youtube),
  //   Channel(channelName: "Al Jazeera English", link: "https://live-hls-web-aje.getaj.net/AJE/index.m3u8", source: Source.iptv),
  //   Channel(channelName: "Arirang", link: "http://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/playlist.m3u8", source: Source.iptv),
  //   Channel(channelName: "Bloomberg", link: "https://bloomberg.com/media-manifest/streams/us.m3u8", source: Source.iptv),
  //   Channel(channelName: "CBS News", link: "https://cbsnews.akamaized.net/hls/live/2020607/cbsnlineup_8/master.m3u8", source: Source.iptv),
  //   Channel(channelName: "Channel News Asia", link: "https://www.youtube.com/embed/XWq5kBlakcQ?autoplay=1", source: Source.youtube),
  //   Channel(channelName: "CNBC", link: "https://www.youtube.com/embed/9NyxcX3rhQs?autoplay=1", source: Source.youtube),
  //   Channel(channelName: "DW English", link: "https://dwamdstream102.akamaized.net/hls/live/2015525/dwstream102/index.m3u8", source: Source.iptv),
  //   Channel(channelName: "Euronews", link: "https://www.youtube.com/embed/pykpO5kQJ98?autoplay=1", source: Source.youtube),
  //   Channel(channelName: "France 24 English", link: "https://www.youtube.com/embed/h3MuIUNCCzI?autoplay=1", source: Source.youtube),
  //   Channel(channelName: "Global News", link: "https://i.mjh.nz/PlutoTV/62cbef9ebb857100072fc187-alt.m3u8", source: Source.iptv),
  //   Channel(channelName: "Newsmax TV", link: "https://nmxlive.akamaized.net/hls/live/529965/Live_1/index.m3u8", source: Source.iptv),
  //   Channel(channelName: "NHK World Japan", link: "https://nhkwlive-ojp.akamaized.net/hls/live/2003459/nhkwlive-ojp-en/index_4M.m3u8", source: Source.iptv),
  //   Channel(channelName: "PBS America", link: "https://pbs-samsunguk.amagi.tv/playlist.m3u8", source: Source.iptv),
  //   Channel(channelName: "Press TV", link: "https://cdnlive.presstv.ir/cdnlive/smil:cdnlive.smil/playlist.m3u8", source: Source.iptv),
  //   Channel(channelName: "Reuters TV", link: "https://reuters-reutersnow-1-eu.rakuten.wurl.tv/playlist.m3u8", source: Source.iptv),
  //   Channel(channelName: "Sky News", link: "https://i.mjh.nz/PlutoTV/55b285cd2665de274553d66f-alt.m3u8", source: Source.iptv),
  //   Channel(channelName: "TRT World", link: "https://tv-trtworld.medya.trt.com.tr/master.m3u8", source: Source.iptv),
  // ];

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
                    icon: Icon(Icons.star,color: provider.favData!.length > 0  ? Colors.amber : Colors.grey,),
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
                                    builder: (context) =>
                                        IptvPlayer(
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
                                    builder: (context) =>
                                        YoutubePlayer(
                                            youtubeLink: channelData![index]
                                                .link,
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



