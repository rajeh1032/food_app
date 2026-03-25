import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String? name;
  final String? email;
  final String memberSince;

  const ProfileHeader({
    super.key,
    this.name,
    this.email,
    required this.memberSince,
  });

  String _buildInitials() {
    final trimmedName = name?.trim() ?? '';
    if (trimmedName.isNotEmpty) {
      final parts = trimmedName.split(RegExp(r'\s+'));
      final initials = parts
          .where((part) => part.isNotEmpty)
          .take(2)
          .map((part) => part[0].toUpperCase())
          .join();

      if (initials.isNotEmpty) {
        return initials;
      }
    }

    final fallback = email?.trim() ?? '';
    if (fallback.isNotEmpty) {
      return fallback[0].toUpperCase();
    }

    return 'U';
  }

  @override
  Widget build(BuildContext context) {
    final displayName =
        (name?.trim().isNotEmpty ?? false) ? name!.trim() : 'Guest Chef';
    final displayEmail = email?.trim().isNotEmpty == true
        ? email!.trim()
        : 'No email available';

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white.withValues(alpha: 0.22),
            border: Border.all(
              color: AppColors.white.withValues(alpha: 0.65),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.12),
                blurRadius: 28,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Container(
            width: 102.w,
            height: 102.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFF4DE), Color(0xFFFFD692)],
              ),
            ),
            child: Center(
              child: Text(
                _buildInitials(),
                style: AppStyles.displaySmall.copyWith(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          displayName,
          textAlign: TextAlign.center,
          style: AppStyles.headlineMedium.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          displayEmail,
          textAlign: TextAlign.center,
          style: AppStyles.bodyMedium.copyWith(
            color: AppColors.white.withValues(alpha: 0.86),
          ),
        ),
        SizedBox(height: 16.h),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            _ProfilePill(
              icon: Icons.verified_user_outlined,
              label: 'Secure account',
            ),
            _ProfilePill(
              icon: Icons.calendar_today_rounded,
              label: memberSince,
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfilePill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ProfilePill({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: AppColors.white),
          SizedBox(width: 8.w),
          Text(
            label,
            style: AppStyles.labelLarge.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
