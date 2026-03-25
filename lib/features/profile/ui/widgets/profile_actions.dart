import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../cubit/profile_states.dart';
import '../cubit/profile_view_model.dart';

class ProfileActions extends StatelessWidget {
  final ProfileViewModel viewModel;
  final VoidCallback onUpdatePressed;
  final VoidCallback onLogoutPressed;

  const ProfileActions({
    super.key,
    required this.viewModel,
    required this.onUpdatePressed,
    required this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileViewModel, ProfileStates>(
      bloc: viewModel,
      buildWhen: (previous, current) {
        return (previous is ProfileLoadingState) !=
            (current is ProfileLoadingState);
      },
      builder: (context, state) {
        final isLoading = state is ProfileLoadingState;

        return Container(
          width: double.infinity,
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
                        Icons.settings_outlined,
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
                            'Account Actions',
                            style: AppStyles.titleLarge.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Save your latest changes or sign out securely.',
                            style: AppStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 22.h),
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : onUpdatePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      shadowColor: AppColors.transparent,
                      disabledBackgroundColor: AppColors.primaryColor
                          .withValues(alpha: 0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(
                                  color: AppColors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Text('Please wait...', style: AppStyles.buttonLarge),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.save_outlined, size: 22),
                              SizedBox(width: 12.w),
                              Text('Save Changes', style: AppStyles.buttonLarge),
                            ],
                          ),
                  ),
                ),
                SizedBox(height: 14.h),
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: OutlinedButton(
                    onPressed: isLoading ? null : onLogoutPressed,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.errorColor,
                      backgroundColor: AppColors.errorColor.withValues(
                        alpha: 0.04,
                      ),
                      side: BorderSide(
                        color: isLoading
                            ? AppColors.errorColor.withValues(alpha: 0.25)
                            : AppColors.errorColor.withValues(alpha: 0.35),
                        width: 1.4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout_rounded, size: 22),
                        SizedBox(width: 12.w),
                        Text(
                          'Logout',
                          style: AppStyles.buttonLarge.copyWith(
                            color: AppColors.errorColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Your account data stays protected while signed in on this device.',
                  style: AppStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
