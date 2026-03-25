import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class SearchHistory extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String image;
  final String? rate;
  final bool isVertical;

  const SearchHistory({
    super.key,
    required this.title,
    this.subtitle,
    required this.image,
    this.rate,
    this.isVertical = false,
  });

  @override
  Widget build(BuildContext context) {

    final String displayRate = rate != null ? "($rate)" : "(4.5)";

    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: isVertical
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: image.startsWith('http')
                  ? Image.network(
                image,
                width: double.infinity,
                height: 120.h,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                image,
                width: double.infinity,
                height: 120.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10.h),
            Text(title,
                style: AppStyles.titleMedium
                    .copyWith(color: AppColors.black)),
            if (subtitle != null) ...[
              SizedBox(height: 5.h),
              Text(subtitle!,
                  style: AppStyles.titleMedium
                      .copyWith(color: AppColors.gray500)),
            ],
            SizedBox(height: 5.h),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 16.sp),
                SizedBox(width: 4.w),

                Text(
                  displayRate,
                  style: AppStyles.titleSmall.copyWith(color: AppColors.gray500),
                ),
              ],
            ),
          ],
        )
            : Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: image.startsWith('http')
                  ? Image.network(
                image,
                width: 67.w,
                height: 70.h,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                image,
                width: 67.w,
                height: 70.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: AppStyles.titleMedium.copyWith(
                          color: AppColors.black, fontSize: 15.sp)),
                  if (subtitle != null)
                    Text(subtitle!,
                        style: AppStyles.titleMedium
                            .copyWith(color: AppColors.gray500)),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text(
                        displayRate,
                        style: AppStyles.titleSmall.copyWith(color: AppColors.black),
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