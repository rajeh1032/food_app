import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class HomeRecipeTab extends StatelessWidget {
  final String label;
  final bool isSelected;

  const HomeRecipeTab({
    super.key,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 24.w),
      child: Text(
        label,
        style: AppStyles.labelLarge.copyWith(
          color: isSelected ? AppColors.textPrimary : AppColors.textHint,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          height: 20 / 14,
        ),
      ),
    );
  }
}
