import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum _VideoSourceType { asset, network }

class Video extends StatefulWidget {
  const Video.asset({required String asset, super.key})
    : _src = asset,
      _videoSourceType = _VideoSourceType.asset;

  const Video.url({required String url, super.key})
    : _src = url,
      _videoSourceType = _VideoSourceType.network;

  final String _src;

  final _VideoSourceType _videoSourceType;

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = switch (widget._videoSourceType) {
      _VideoSourceType.asset => VideoPlayerController.asset(widget._src),
      _VideoSourceType.network => VideoPlayerController.networkUrl(
        Uri.parse(widget._src),
      ),
    };

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
              Center(
                child: FloatingActionButton(
                  child: ListenableBuilder(
                    listenable: _controller,
                    builder: (context, child) {
                      return Icon(
                        _controller.value.isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                      );
                    },
                  ),
                  onPressed: () {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  },
                ),
              ),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
