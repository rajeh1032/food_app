import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../Domain/entity/saved_meal_entity.dart';

class SavedMealCard extends StatelessWidget {
  final SavedMealEntity meal;
  final VoidCallback onRemove;
  final VoidCallback? onTap;

  const SavedMealCard({
    super.key,
    required this.meal,
    required this.onRemove,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: CachedNetworkImage(
                imageUrl: meal.mealThumb,
                width: double.infinity,
                height: 120.h,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Container(
                  height: 120.h,
                  color: AppColors.textHint.withValues(alpha: 0.15),
                  child: Icon(Icons.fastfood_rounded,
                      color: AppColors.textHint, size: 32.sp),
                ),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name - دايماً سطرين بالظبط
                    SizedBox(
                      height: 36.h,
                      child: Text(
                        meal.mealName,
                        style: AppStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          fontSize: 12.sp,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded,
                            color: AppColors.timerColor, size: 11.sp),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            meal.time.isNotEmpty ? meal.time : '30 min',
                            style: AppStyles.labelSmall.copyWith(
                                color: AppColors.textHint, fontSize: 10.sp),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: onRemove,
                          child: Icon(
                            Icons.bookmark_rounded,
                            color: AppColors.primaryColor,
                            size: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
