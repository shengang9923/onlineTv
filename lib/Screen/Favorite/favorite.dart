import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinetv/Constants/source_type.dart';
import 'package:onlinetv/Providers/app_provider.dart';
import 'package:onlinetv/Screen/Home/widget.dart';
import 'package:provider/provider.dart';

import '../IPTV/iptv_player.dart';
import '../Youtube/youtubetest.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.favData!.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  onTap: (){
                    if (provider.favData![index].source == Source.iptv) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IptvPlayer(
                                iptvUrl: provider.favData![index].link,
                                channelName:
                                provider.favData![index].channelName,
                                thumbnail:
                                provider.favData![index].thumbnail,
                              )));
                    } else if ( provider.favData![index].source ==
                        Source.youtube) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => YoutubePlayer(
                                  youtubeLink:  provider.favData![index].link,
                                  channelName:
                                  provider.favData![index].channelName,
                                  thumbnail:
                                  provider.favData![index].thumbnail)));
                    }
                  },
                  leading: SourceIcon(source: provider.favData![index].source),
                  title: Text("${provider.favData![index].channelName}"),
                  trailing:IconButton(onPressed: (){
                    Provider.of<AppProvider>(context, listen: false).removeFav(provider.favData![index].channelName);
                  },icon:Icon( Icons.star,color: Colors.amber,))
                ),
              );
            },
          );
        },
      ),
    );
  }
}
