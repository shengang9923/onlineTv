import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:video_player/video_player.dart';

class IptvPlayer extends StatefulWidget {
  final iptvUrl;
  final channelName;
  final thumbnail;
  const IptvPlayer(
      {super.key,
      required this.iptvUrl,
      required this.channelName,
      required this.thumbnail});
  @override
  State<IptvPlayer> createState() => _IptvPlayerState();
}

class _IptvPlayerState extends State<IptvPlayer> {
  _IptvPlayerState();

  late VideoPlayerController _videoPlayerController;

  bool _appBarVisibility = true;

  _hideUnhideAppBar() {
    setState(() {
      _appBarVisibility = !_appBarVisibility;
      if (!_appBarVisibility) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ]);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse('${widget.iptvUrl}'))
          ..initialize().then((_) {
            setState(() {});
            _videoPlayerController.play();
          });
  }

  @override
  void dispose() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBarVisibility
            ? AppBar(
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
              )
            : null,
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: () => _hideUnhideAppBar(),
          child: Center(
            child: _videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController))
                : const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()),
          ),
        ),
        bottomNavigationBar:
            (MediaQuery.of(context).orientation == Orientation.portrait)
                ? const Padding(
                    padding: EdgeInsets.all(27.0),
                    child: Text(
                      'Tap the video for full screen viewing',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : null);
  }
}
