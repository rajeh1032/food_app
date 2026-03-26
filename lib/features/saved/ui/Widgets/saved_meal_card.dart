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
            // Image with bookmark overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                  child: CachedNetworkImage(
                    imageUrl: meal.mealThumb,
                    width: double.infinity,
                    height: 130.h,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => Container(
                      height: 130.h,
                      color: AppColors.textHint.withValues(alpha: 0.15),
                      child: Icon(Icons.fastfood_rounded,
                          color: AppColors.textHint, size: 36.sp),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(
                        Icons.bookmark_rounded,
                        color: AppColors.primaryColor,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Name
            Padding(
              padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 8.h),
              child: Text(
                meal.mealName,
                style: AppStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}