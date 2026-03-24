import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../../core/utils/custom_text_field.dart';
import '../../../../core/utils/validators.dart';

/// Login form widget
class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final VoidCallback onNavigateToRegister;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
    required this.onNavigateToRegister,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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

          // Login button
          CustomButton(
            body: Text('Login', style: AppStyles.buttonLarge),
            backgroundColor: AppColors.primaryColor,
            onPressed: widget.onLogin,
          ),
          SizedBox(height: 16.h),

          // Navigate to register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              GestureDetector(
                onTap: widget.onNavigateToRegister,
                child: Text(
                  'Sign Up',
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
