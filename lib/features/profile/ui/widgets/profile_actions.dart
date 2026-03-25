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
        // Only rebuild when loading state changes
        return (previous is ProfileLoadingState) !=
            (current is ProfileLoadingState);
      },
      builder: (context, state) {
        final isLoading = state is ProfileLoadingState;

        return Column(
          children: [
            // Update Button
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: isLoading ? null : onUpdatePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.white,
                  elevation: 2,
                  shadowColor: AppColors.primaryColor.withOpacity(0.3),
                  disabledBackgroundColor: AppColors.primaryColor.withOpacity(
                    0.6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text('Updating...', style: AppStyles.buttonLarge),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.save_outlined, size: 22),
                          SizedBox(width: 12.w),
                          Text('Update Profile', style: AppStyles.buttonLarge),
                        ],
                      ),
              ),
            ),
            SizedBox(height: 16.h),

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: OutlinedButton(
                onPressed: isLoading ? null : onLogoutPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.errorColor,
                  side: BorderSide(
                    color: isLoading
                        ? AppColors.errorColor.withOpacity(0.4)
                        : AppColors.errorColor,
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.logout, size: 22),
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
          ],
        );
      },
    );
  }
}
