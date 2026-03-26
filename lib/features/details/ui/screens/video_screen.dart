import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../widgets/circle_icon_button.dart';
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
  late final YoutubePlayerController controller;
  late final String _videoId;

  @override
  void initState() {
    super.initState();

    _videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl) ?? '';

    controller = YoutubePlayerController(
      initialVideoId: _videoId,
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
      backgroundColor: AppColors.gray50,
      appBar: AppBar(
        backgroundColor: AppColors.gray50,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leadingWidth: 70.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: CircleIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.maybePop(context),
          ),
        ),
        title: Text(
          "Watch Video",
          style: AppStyles.headlineMedium.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryColor.withValues(alpha: 0.18),
                  AppColors.secondaryColor.withValues(alpha: 0.12),
                ],
              ),
              borderRadius: BorderRadius.circular(28.r),
            ),
            padding: EdgeInsets.all(10.w),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.08),
                    blurRadius: 22.r,
                    offset: Offset(0, 10.h),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.r),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child:
                      _videoId.isEmpty
                          ? _buildInvalidVideoState()
                          : YoutubePlayer(
                            controller: controller,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: AppColors.primaryColor,
                            progressColors: const ProgressBarColors(
                              playedColor: AppColors.primaryColor,
                              handleColor: AppColors.primaryDark,
                              bufferedColor: AppColors.gray300,
                              backgroundColor: AppColors.gray100,
                            ),
                          ),
                ),
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [
              _VideoInfoChip(
                icon: Icons.play_circle_fill_rounded,
                label: 'Recipe video',
              ),
              _VideoInfoChip(
                icon: Icons.restaurant_menu_rounded,
                label: '${widget.ingredients.length} ingredients',
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Container(
            padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 14.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.05),
                  blurRadius: 20.r,
                  offset: Offset(0, 8.h),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: 'Ingredients'),
                SizedBox(height: 4.h),
                Text(
                  'Everything you need for this recipe',
                  style: AppStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 14.h),
                IngredientsList(
                  ingredients: widget.ingredients,
                  measures: widget.measures,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvalidVideoState() {
    return Container(
      color: AppColors.textPrimary,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.play_disabled_rounded,
              color: AppColors.white,
              size: 46.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              'Video unavailable',
              style: AppStyles.titleLarge.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'This recipe does not have a valid YouTube link yet.',
              textAlign: TextAlign.center,
              style: AppStyles.bodySmall.copyWith(
                color: AppColors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _VideoInfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.gray100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16.sp,
            color: AppColors.primaryColor,
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: AppStyles.labelLarge.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
