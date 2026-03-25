import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../../core/utils/custom_text_field.dart';
import '../../../../core/utils/validators.dart';

/// Registration form widget
class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onRegister;
  final VoidCallback onNavigateToLogin;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.onRegister,
    required this.onNavigateToLogin,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Name field
          CustomTextField(
            controller: widget.nameController,
            hintText: 'Enter your name',
            labelText: 'Name',
            keyboardType: TextInputType.name,
            prefixIcon: Icon(Icons.person_outline, color: AppColors.textHint),
            validator: (val) =>
                AppValidators.validateRequired(val, fieldName: 'Name'),
          ),
          SizedBox(height: 16.h),

          // Email field
          CustomTextField(
            controller: widget.emailController,
            hintText: 'Enter your email',
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icon(Icons.email_outlined, color: AppColors.textHint),
            validator: AppValidators.validateEmail,
          ),
          SizedBox(height: 16.h),

          // Password field
          CustomTextField(
            controller: widget.passwordController,
            hintText: 'Enter your password',
            labelText: 'Password',
            obscureText: _obscurePassword,
            prefixIcon: Icon(Icons.lock_outline, color: AppColors.textHint),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.textHint,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            validator: AppValidators.validatePassword,
          ),
          SizedBox(height: 24.h),

          // Register button
          CustomButton(
            body: Text('Sign Up', style: AppStyles.buttonLarge),
            backgroundColor: AppColors.primaryColor,
            onPressed: widget.onRegister,
          ),
          SizedBox(height: 16.h),

          // Navigate to login
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              GestureDetector(
                onTap: widget.onNavigateToLogin,
                child: Text(
                  'Login',
                  style: AppStyles.bodyMedium.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
