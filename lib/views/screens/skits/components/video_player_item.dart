import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  const VideoPlayerItem({
    super.key,
    required this.skitUrl,
  });

  final String skitUrl;

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _videoController;
  late Future _initializeVideoPlayer;
  bool _isVideoPlaying = true;

  @override
  void initState() {
    _videoController = VideoPlayerController.network(widget.skitUrl);
    _initializeVideoPlayer = _videoController.initialize().then((value) {
      _videoController.play();
      _videoController.setVolume(1);
      _videoController.setLooping(true);
    });
    super.initState();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _pausePlayVideo() {
    _isVideoPlaying ? _videoController.pause() : _videoController.play();
    setState(() {
      _isVideoPlaying = !_isVideoPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: lightBlack,
      width: size.width,
      height: size.height,
      child: FutureBuilder(
        future: _initializeVideoPlayer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () {
                _pausePlayVideo();
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_videoController),
                  IconButton(
                    onPressed: () {
                      _pausePlayVideo();
                    },
                    icon: Icon(
                      Icons.play_arrow,
                      color:
                          Colors.white.withOpacity(_isVideoPlaying ? 0 : 0.5),
                      size: 60,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      VideoProgressIndicator(
                        _videoController,
                        allowScrubbing: true,
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
              // child: Lottie.asset(
              //   "images/icons/loading1.gif",
              //   width: 200,
              //   height: 150,
              //   fit: BoxFit.contain,
              // ),
              // color: Color(0xFF6D4901),
            );
          }
        },
      ),
    );
  }
}
