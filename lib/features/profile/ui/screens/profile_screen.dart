import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../Domain/Entity/profile_user_entity.dart';
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
  final ProfileViewModel viewModel = getIt<ProfileViewModel>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  ProfileUserEntity? _cachedUser;

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
          borderRadius: BorderRadius.circular(18.r),
        ),
        title: Row(
          children: [
            Icon(Icons.logout_rounded, color: AppColors.errorColor),
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

  void _syncControllers(ProfileUserEntity user) {
    final nextName = user.name ?? '';
    final nextEmail = user.email ?? '';

    if (_nameController.text != nextName) {
      _nameController.text = nextName;
    }
    if (_emailController.text != nextEmail) {
      _emailController.text = nextEmail;
    }
  }

  String _formatMemberSince(String? rawDate) {
    if (rawDate == null || rawDate.trim().isEmpty) {
      return 'Fresh member';
    }

    final parsedDate = DateTime.tryParse(rawDate);
    if (parsedDate == null) {
      return 'Fresh member';
    }

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${months[parsedDate.month - 1]} ${parsedDate.year}';
  }

  String _buildUserTag(String? uid) {
    if (uid == null || uid.trim().isEmpty) {
      return 'Guest';
    }

    final normalizedUid = uid.trim();
    final suffix = normalizedUid.length <= 6
        ? normalizedUid
        : normalizedUid.substring(normalizedUid.length - 6);

    return '#${suffix.toUpperCase()}';
  }

  Widget _buildHeroSection(ProfileUserEntity user) {
    final topInset = MediaQuery.paddingOf(context).top;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, topInset + 20.h, 24.w, 68.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFC469),
            AppColors.primaryColor,
            AppColors.primaryDark,
          ],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(36.r)),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8.h,
            right: -18.w,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            left: -32.w,
            bottom: 28.h,
            child: Container(
              width: 96.w,
              height: 96.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Profile',
                style: AppStyles.displaySmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 250.w),
                child: Text(
                  'Manage your details, keep your identity polished, and stay ready for the next recipe.',
                  style: AppStyles.bodyMedium.copyWith(
                    color: AppColors.white.withValues(alpha: 0.84),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Center(
                child: ProfileHeader(
                  name: user.name,
                  email: user.email,
                  memberSince: _formatMemberSince(user.createdAt),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(color: AppColors.primaryColor),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(28.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.05),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  color: AppColors.errorColor.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 36.sp,
                  color: AppColors.errorColor,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Unable to load profile',
                style: AppStyles.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Text(
                message,
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: viewModel.getProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 28.w,
                    vertical: 15.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                icon: const Icon(Icons.refresh_rounded),
                label: Text('Try Again', style: AppStyles.buttonMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileViewModel, ProfileStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is ProfileLoadedState) {
          _cachedUser = state.user;
        } else if (state is ProfileUpdatedState) {
          _cachedUser = state.user;
          _syncControllers(state.user);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                backgroundColor: AppColors.primaryColor,
                content: Text('Profile updated successfully'),
              ),
            );
        } else if (state is ProfileErrorState && _cachedUser != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: AppColors.errorColor,
                content: Text(state.message),
              ),
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
        backgroundColor: const Color(0xFFFFFAF4),
        body: BlocBuilder<ProfileViewModel, ProfileStates>(
          bloc: viewModel,
          builder: (context, state) {
            final user = switch (state) {
              ProfileLoadedState(:final user) => user,
              ProfileUpdatedState(:final user) => user,
              _ => _cachedUser,
            };

            if (user != null) {
              _cachedUser = user;
              _syncControllers(user);
            }

            if (state is ProfileLoadingState && user == null) {
              return _buildLoadingState();
            }

            if (state is ProfileErrorState && user == null) {
              return _buildErrorState(state.message);
            }

            if (user == null) {
              return _buildLoadingState();
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeroSection(user),
                  Transform.translate(
                    offset: Offset(0, -34.h),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ProfileInfoCard(
                              emailController: _emailController,
                              nameController: _nameController,
                              memberSince: _formatMemberSince(user.createdAt),
                              userTag: _buildUserTag(user.uid),
                            ),
                            SizedBox(height: 20.h),
                            ProfileActions(
                              viewModel: viewModel,
                              onUpdatePressed: _handleUpdateProfile,
                              onLogoutPressed: _handleLogout,
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
