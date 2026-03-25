import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/validators.dart';

class ProfileInfoCard extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController nameController;

  const ProfileInfoCard({
    super.key,
    required this.emailController,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.primaryColor,
                  size: 24,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Personal Information',
                  style: AppStyles.titleLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Email Field (Read-only)
            _buildFieldLabel('Email Address'),
            SizedBox(height: 8.h),
            TextFormField(
              controller: emailController,
              enabled: false,
              style: AppStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: AppColors.textHint,
                ),
                filled: true,
                fillColor: AppColors.gray100,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Name Field (Editable)
            _buildFieldLabel('Full Name'),
            SizedBox(height: 8.h),
            TextFormField(
              controller: nameController,
              validator: AppValidators.validateName,
              style: AppStyles.bodyMedium,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: AppColors.primaryColor,
                ),
                filled: true,
                fillColor: AppColors.surfaceColor,
                hintText: 'Enter your name',
                hintStyle: AppStyles.bodyMedium.copyWith(
                  color: AppColors.textHint,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.gray300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.gray300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.errorColor),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.errorColor, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: AppStyles.labelLarge.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
