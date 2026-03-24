import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/shared_pref_services.dart';
import '../../../../core/di/di.dart';
import '../../../../core/routes/route_names.dart';
import '../../../auth/ui/cubit/auth_view_model.dart';

/// Profile screen with user ID display and logout
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  void _loadUserId() {
    setState(() {
      userId = SharedPrefService.instance.getUserId();
    });
  }

  void _handleLogout() {
    final authViewModel = getIt<AuthViewModel>();
    authViewModel.logout();

    // التوجيه لصفحة Login
    Navigator.pushReplacementNamed(context, RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      appBar: AppBar(
        title: Text('Profile', style: AppStyles.headlineMedium),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),

            // عرض User ID
            if (userId != null) ...[
              Text('User ID:', style: AppStyles.labelLarge),
              SizedBox(height: 8.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.surfaceColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.gray300),
                ),
                child: SelectableText(
                  userId!,
                  style: AppStyles.bodyMedium.copyWith(
                    fontFamily: 'monospace',
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
            ] else ...[
              Text(
                'Not logged in',
                style: AppStyles.bodyLarge.copyWith(
                  color: AppColors.errorColor,
                ),
              ),
              SizedBox(height: 32.h),
            ],

            const Spacer(),

            // زر تسجيل الخروج
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton.icon(
                onPressed: _handleLogout,
                icon: const Icon(Icons.logout),
                label: Text('Logout', style: AppStyles.buttonLarge),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.errorColor,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
