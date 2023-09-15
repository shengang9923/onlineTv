import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class YoutubePlayer extends StatefulWidget {
  final youtubeLink;
  final channelName;
  final thumbnail;

  const YoutubePlayer(
      {super.key,
      required this.youtubeLink,
      required this.channelName,
      required this.thumbnail});
  @override
  State<YoutubePlayer> createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: CachedNetworkImage(
                  errorWidget: (context, str, dyna) =>
                      Icon(Icons.image_not_supported),
                  placeholder: (context, url) => SizedBox(
                      width: 50,
                      height: 50,
                      child: Opacity(
                          opacity: 0.3,
                          child: const LinearProgressIndicator())),
                  imageUrl: widget.thumbnail,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              // Text("${widget.channelName}"),
            ],
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: InAppWebView(
          initialUrlRequest:
              URLRequest(url: Uri.parse('${widget.youtubeLink}')),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              mediaPlaybackRequiresUserGesture: false,
              incognito: true,
            ),
          ),
          onEnterFullscreen: (controller) {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight
            ]);
          },
          onExitFullscreen: (controller) {
            SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          },
        ));
  }
}
