import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class AuthorRow extends StatelessWidget {
  const AuthorRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        CircleAvatar(
          radius: 18.r,
          backgroundColor: AppColors.primaryLight,
          child: Icon(
            Icons.person_rounded,
            color: AppColors.primaryColor,
            size: 20.sp,
          ),
        ),

        SizedBox(width: 10.w),

        Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Text(
              'Yumna Azzahra',
              style: AppStyles.titleMedium.copyWith(
                fontSize: 13.5.sp,
              ),
            ),

            Text(
              '@yumnaazzhr01',
              style: AppStyles.bodySmall.copyWith(
                fontSize: 11.5.sp,
              ),
            ),
          ],
        ),

        const Spacer(),

        Container(height: 35.h,width: 90.w,
          child: OutlinedButton(
            onPressed: () {},

            style: OutlinedButton.styleFrom(
              foregroundColor:
              AppColors.primaryColor,

              side: BorderSide(
                color: AppColors.primaryColor,
                width: 1.5,
              ),

              padding: EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: 6.h,
              ),

              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.r),
              ),

              minimumSize: Size.zero,
              tapTargetSize:
              MaterialTapTargetSize.shrinkWrap,
            ),

            child: Text(
              'Follow',
              style:
              AppStyles.buttonSmall.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}