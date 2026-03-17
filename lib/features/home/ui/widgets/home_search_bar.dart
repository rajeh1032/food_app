import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class HomeSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback onSearch;
  final ValueChanged<String>? onSubmitted;

  const HomeSearchBar({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onSearch,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        onSubmitted: onSubmitted,
        style: AppStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStyles.bodyMedium.copyWith(
            color: AppColors.gray400,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          suffixIcon: IconButton(
            onPressed: onSearch,
            icon: Icon(
              Icons.search_rounded,
              color: AppColors.gray400,
              size: 22.sp,
            ),
          ),
        ),
      ),
    );
  }
}
