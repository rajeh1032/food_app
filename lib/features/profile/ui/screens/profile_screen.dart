import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../cubit/profile_states.dart';
import '../cubit/profile_view_model.dart';
import '../widgets/profile_actions.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_info_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  ProfileViewModel viewModel = getIt<ProfileViewModel>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.getProfile();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleUpdateProfile() {
    if (_formKey.currentState!.validate()) {
      viewModel.updateName(_nameController.text.trim());
    }
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(Icons.logout, color: AppColors.errorColor),
            SizedBox(width: 12.w),
            Text('Logout', style: AppStyles.headlineSmall),
          ],
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: AppStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppStyles.labelLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              viewModel.logout();
            },
            child: Text(
              'Logout',
              style: AppStyles.labelLarge.copyWith(
                color: AppColors.errorColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileViewModel, ProfileStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is ProfileUpdatedState) {
          DialogUtils.showSuccess(
            context: context,
            message: 'Profile updated successfully',
            title: 'Success',
          );
        } else if (state is ProfileLogoutSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.login,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBgColor,
        body: BlocBuilder<ProfileViewModel, ProfileStates>(
          bloc: viewModel,
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }

            if (state is ProfileErrorState) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(32.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 80,
                        color: AppColors.errorColor,
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'Error loading profile',
                        style: AppStyles.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        state.message,
                        style: AppStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.h),
                      ElevatedButton.icon(
                        onPressed: () => viewModel.getProfile(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: AppColors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 16.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        icon: const Icon(Icons.refresh),
                        label: Text('Retry', style: AppStyles.buttonMedium),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Populate fields when data is loaded
            if (state is ProfileLoadedState || state is ProfileUpdatedState) {
              final user = state is ProfileLoadedState
                  ? state.user
                  : (state as ProfileUpdatedState).user;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_nameController.text != user.name) {
                  _nameController.text = user.name ?? '';
                }
                if (_emailController.text != user.email) {
                  _emailController.text = user.email ?? '';
                }
              });
            }

            return CustomScrollView(
              slivers: [
                // App Bar with gradient
                SliverAppBar(
                  expandedHeight: 200.h,
                  floating: false,
                  pinned: true,
                  backgroundColor: AppColors.primaryColor,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      'My Profile',
                      style: AppStyles.headlineSmall.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.warningColor,
                            AppColors.primaryDark,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: const ProfileHeader(),
                        ),
                      ),
                    ),
                  ),
                ),

                // Content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 8.h),

                          // Profile Info Card
                          ProfileInfoCard(
                            emailController: _emailController,
                            nameController: _nameController,
                          ),

                          SizedBox(height: 32.h),

                          // Actions
                          ProfileActions(
                            viewModel: viewModel,
                            onUpdatePressed: _handleUpdateProfile,
                            onLogoutPressed: _handleLogout,
                          ),

                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
