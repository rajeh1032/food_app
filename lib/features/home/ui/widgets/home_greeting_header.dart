import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class HomeGreetingHeader extends StatelessWidget {
  final String avatarAssetPath;
  final String greeting;
  final String userName;

  const HomeGreetingHeader({
    super.key,
    required this.avatarAssetPath,
    required this.greeting,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: Image.asset(
            avatarAssetPath,
            width: 48.w,
            height: 48.w,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.gray400,
                  height: 18 / 14,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                userName,
                style: AppStyles.titleLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: 22.sp,
                color: AppColors.textPrimary,
              ),
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: AppColors.errorColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 1.5),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
