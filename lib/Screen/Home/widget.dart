import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../Constants/source_type.dart';
import '../../Model/model.dart';
import '../../Providers/app_provider.dart';

class SourceIcon extends StatelessWidget {
  final source;
  const SourceIcon({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    if (source == Source.iptv)
      return IconButton(
        onPressed: () {},
        icon: const FaIcon(FontAwesomeIcons.tv),
      );
    else
      return IconButton(
        onPressed: () {},
        icon: const FaIcon(FontAwesomeIcons.youtube,color: Colors.red,),
      );
  }
}

class ItemHolder extends StatefulWidget {
  ItemHolder({super.key, required this.channelData, required this.index});

  final List<ChannelModel>? channelData;
  final index;

  @override
  State<ItemHolder> createState() => _ItemHolderState();
}

class _ItemHolderState extends State<ItemHolder> {
  // bool selected = false;

  void saveFav(provider, context, channel_name, link, source, thumbnail) {
    if (provider.clickFav!.any((jsonObject) =>
        jsonObject['channel_name'] ==
        widget.channelData![widget.index].channelName)) {
      Provider.of<AppProvider>(context, listen: false).removeFav(channel_name);
    } else {
      String addData = '''
  {
    "channel_name": "$channel_name",
    "link": "$link",
    "source": "$source",
    "thumbnail" : "$thumbnail"
}
  ''';
      Provider.of<AppProvider>(context, listen: false)
          .setFav(addData, channel_name);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AppProvider>(context, listen: false).getFav();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.black12),
          child: CachedNetworkImage(
            errorWidget: (context, str, dyna) =>
                Icon(Icons.image_not_supported),
            placeholder: (context, url) => SizedBox(
                width: 50,
                height: 50,
                child: Opacity(
                    opacity: 0.3, child: const LinearProgressIndicator())),
            imageUrl: widget.channelData![widget.index].thumbnail,
          ),
        ),
        Positioned(
            top: 10,
            left: 5,
            child:
                SourceIcon(source: widget.channelData![widget.index].source)),
        Positioned(
            top: 10,
            right: 5,
            child: Consumer<AppProvider>(
              builder: (context, provider, child) {
                return IconButton(
                    onPressed: () {
                      final cName =
                          widget.channelData![widget.index].channelName;
                      final link = widget.channelData![widget.index].link;
                      final source = widget.channelData![widget.index].source;
                      final thumbnail =
                          widget.channelData![widget.index].thumbnail;
                      saveFav(
                          provider, context, cName, link, source, thumbnail);

                      //  selected = !selected;

                      setState(() {});
                    },
                    icon: Icon(
                      Icons.star,
                      color: provider.clickFav!.any((jsonObject) =>
                              jsonObject['channel_name'] ==
                              widget.channelData![widget.index].channelName)
                          ? Colors.amber
                          : Colors.white,
                    ));
              },
            ))
      ],
    );
  }
}
