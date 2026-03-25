import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../screens/video_screen.dart';

class WatchVideoButton extends StatelessWidget {

  final String youtubeUrl;

  const WatchVideoButton({
    super.key,
    required this.youtubeUrl,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoScreen(
              youtubeUrl: youtubeUrl,
            ),
          ),
        );

      },

      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 28.w,
          vertical: 14.h,
        ),

        decoration: BoxDecoration(
          color: AppColors.primaryColor,

          borderRadius:
          BorderRadius.circular(32.r),

          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor
                  .withOpacity(0.4),

              blurRadius: 16.r,

              offset: Offset(0, 6.h),
            ),
          ],
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Icon(
              Icons.play_circle_fill_rounded,
              color: AppColors.white,
              size: 22.sp,
            ),

            SizedBox(width: 8.w),

            Text(
              'Watch Video',
              style:
              AppStyles.buttonMedium.copyWith(
                fontSize: 15.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}