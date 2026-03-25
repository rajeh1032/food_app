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
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(12.r),
              ),
              child: Image.network(
                meal.mealThumb,
                width: 100.w,
                height: 90.h,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 100.w,
                  height: 90.h,
                  color: AppColors.textHint.withValues(alpha: 0.2),
                  child: Icon(
                    Icons.fastfood_rounded,
                    color: AppColors.textHint,
                    size: 32.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),

            // Title
            Expanded(
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
            SizedBox(width: 8.w),

            // Remove bookmark button
            IconButton(
              onPressed: onRemove,
              icon: Icon(
                Icons.bookmark_rounded,
                color: AppColors.primaryColor,
                size: 22.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}