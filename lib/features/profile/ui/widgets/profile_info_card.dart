import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/validators.dart';

class ProfileInfoCard extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController nameController;
  final String memberSince;
  final String userTag;

  const ProfileInfoCard({
    super.key,
    required this.emailController,
    required this.nameController,
    required this.memberSince,
    required this.userTag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.gray100),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1DB),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    Icons.badge_outlined,
                    color: AppColors.primaryColor,
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: AppStyles.titleLarge.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Refresh your account details and keep everything up to date.',
                        style: AppStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7EA),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  child: Text(
                    'Editable',
                    style: AppStyles.labelMedium.copyWith(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFFF7EA), Color(0xFFFFFFFF)],
                ),
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: const Color(0xFFFFE6BF)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildMetaItem(
                      icon: Icons.calendar_month_rounded,
                      label: 'Member Since',
                      value: memberSince,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 38.h,
                    color: AppColors.gray200,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _buildMetaItem(
                      icon: Icons.fingerprint_rounded,
                      label: 'Profile ID',
                      value: userTag,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
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
                fillColor: AppColors.gray50,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.gray200),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.gray200),
                ),
              ),
            ),
            SizedBox(height: 22.h),
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
                fillColor: const Color(0xFFFFFCF7),
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

  Widget _buildMetaItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34.w,
          height: 34.w,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            icon,
            size: 18.sp,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppStyles.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.labelLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
