import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

/// Reusable custom text button widget
class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? textColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  const CustomTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor,
    this.textStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? AppColors.primaryColor,
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
      child: Text(
        text,
        style:
            textStyle ??
            AppStyles.buttonMedium.copyWith(
              color: textColor ?? AppColors.primaryColor,
            ),
      ),
    );
  }
}
