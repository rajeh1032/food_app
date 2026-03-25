import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

/// Reusable custom button widget
class CustomButton extends StatelessWidget {
  final Widget body;
  final Color? color;
  final Color? backgroundColor;
  final double? borderRadius;
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.body,
    this.onPressed,
    this.color,
    this.backgroundColor,
    this.borderRadius,
    this.width,
    this.height,
    this.padding,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 48.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          foregroundColor: color ?? AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
          ),
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.h,
                child: CircularProgressIndicator(
                  color: color ?? AppColors.white,
                  strokeWidth: 2,
                ),
              )
            : body,
      ),
    );
  }
}
