import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../widgets/ingredients_list.dart';
import '../widgets/section_title.dart';

class VideoScreen extends StatefulWidget {
  final String youtubeUrl;
  final List<String> ingredients;
  final List<String> measures;
  const VideoScreen({
    super.key,
    required this.youtubeUrl, required this.ingredients, required this.measures,
  });

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl);

    controller = YoutubePlayerController(
      initialVideoId: videoId ?? "",
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Center(
            child: YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: true,
              width: 350,

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:24,top: 8),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[const SectionTitle(
                title: 'Ingredients'),

            SizedBox(height: 10.h),
            IngredientsList(
              ingredients:
              widget.ingredients,
              measures:
              widget.measures,
            ),]),
          )

        ],
      ),
    );
  }
}