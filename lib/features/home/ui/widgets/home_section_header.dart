import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class HomeSectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;

  const HomeSectionHeader({super.key, required this.title, this.actionLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppStyles.titleLarge.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        ),
        if (actionLabel != null)
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Text(
              actionLabel!,
              style: AppStyles.labelLarge.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
                height: 20 / 14,
              ),
            ),
          ),
      ],
    );
  }
}
