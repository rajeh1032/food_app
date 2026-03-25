import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../details/ui/screens/details_screen.dart';
import 'home_network_image.dart';

class HomeMealCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String timeLabel;
  final String idMeal;

  const HomeMealCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.timeLabel,
    required this.idMeal
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailPage(mealId: idMeal,),
          ),
        );
      },
      child: Container(
        width: 300.w,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeNetworkImage(
              imageUrl: imageUrl,
              width: 300.w,
              height: 158.h,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              fallbackIcon: Icons.fastfood_rounded,
              fallbackIconSize: 40,
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.headlineSmall,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 16.sp,
                        color: AppColors.textHint,
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          timeLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.bodySmall.copyWith(
                            color: AppColors.textHint,
                          ),
                        ),
                      ),
                      Container(
                        width: 34.w,
                        height: 34.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite_border_rounded,
                            size: 18.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
