import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class HomeIngredientChip extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isSelected;

  const HomeIngredientChip({
    super.key,
    required this.emoji,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        '$emoji $label',
        style: AppStyles.labelLarge.copyWith(
          color: isSelected ? AppColors.white : AppColors.gray400,
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
          height: 22 / 14,
        ),
      ),
    );
  }
}
