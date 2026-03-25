import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class LastViewed extends StatelessWidget {
  final String image;
  final String title;
  final String rate;

  const LastViewed({
    super.key,
    required this.title,
    required this.image,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      margin: EdgeInsets.only(right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              image,
              width: 150.w,
              height: 95.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: AppStyles.titleMedium
                .copyWith(color: AppColors.black, fontSize: 13.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(Icons.star, color: AppColors.secondaryColor, size: 16.sp),
              SizedBox(width: 4.w),
              Text(
                "(${rate})",
                style: AppStyles.titleSmall.copyWith(
                  color: AppColors.black,
                  fontSize: 12.sp,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
