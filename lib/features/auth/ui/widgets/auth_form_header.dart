import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

/// Reusable header widget for auth forms
class AuthFormHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthFormHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.displayMedium.copyWith(color: AppColors.textPrimary),
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          style: AppStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
