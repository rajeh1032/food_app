import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {

  final String youtubeUrl;

  const VideoScreen({
    super.key,
    required this.youtubeUrl,
  });

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    final videoId =
    YoutubePlayer.convertUrlToId(widget.youtubeUrl);

    controller = YoutubePlayerController(
      initialVideoId: videoId ??"",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Watch Video"),
      ),

      body: Column(
        children: [
          YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
          ),

        ],
      ),
    );
  }
}