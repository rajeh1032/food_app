import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import 'home_network_image.dart';
import 'recipe_meta_item.dart';

class PopularRecipeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String rating;
  final String time;
  final String views;

  const PopularRecipeCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.time,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 159.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeNetworkImage(
            imageUrl: imageUrl,
            width: 159.w,
            height: 145.h,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
            fallbackIcon: Icons.ramen_dining_rounded,
            fallbackIconSize: 36,
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    height: 20 / 14,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    RecipeMetaItem(
                      icon: Icons.star_rounded,
                      label: '($rating)',
                      iconColor: AppColors.ratingColor,
                    ),
                    SizedBox(width: 10.w),
                    RecipeMetaItem(
                      icon: Icons.access_time_rounded,
                      label: time,
                      iconColor: AppColors.timerColor,
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    RecipeMetaItem(
                      icon: Icons.remove_red_eye_outlined,
                      label: views,
                      iconColor: AppColors.textHint,
                    ),
                    const Spacer(),
                    Icon(
                      Icons.bookmark_border_rounded,
                      color: AppColors.textHint,
                      size: 18.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
