import 'package:flutter/material.dart';
import 'package:video_player_blank_frame_bug/video.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'video_player', home: VideoPlayerScreen());
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('video_player')),
      body: Column(
        children: [
          Expanded(child: Video.asset(asset: 'assets/butterfly.mp4')),
          Expanded(
            // TRY OTHER URLs:
            // https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4
            // https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4
            // https://player.vimeo.com/progressive_redirect/playback/826096503/rendition/1080p/file.mp4?loc=external&oauth2_token_id=1336102545&signature=cbf11795d6a877ef9bc010d16d32e91d6b3f5c5b01ed6ced5f48c20f55137607
            child: Video.url(
              url:
                  'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
            ),
          ),
        ],
      ),
    );
  }
}
