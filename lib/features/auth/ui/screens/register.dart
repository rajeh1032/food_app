import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../cubit/auth_states.dart';
import '../cubit/auth_view_model.dart';
import '../widgets/auth_form_header.dart';
import '../widgets/register_form.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final AuthViewModel viewModel = getIt<AuthViewModel>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      viewModel.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: viewModel,
      listener: (context, state) {
        if (state is AuthLoadingState) {
          DialogUtils.showLoading(
            context: context,
            message: 'Creating account...',
          );
        } else if (state is AuthErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showError(
            context: context,
            message: state.message,
            title: 'Registration Failed',
          );
        } else if (state is RegisterSuccessState) {
          DialogUtils.hideLoading(context);
          // Navigate to root/home
          Navigator.pushReplacementNamed(context, RouteNames.root);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBgColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40.h),

                // Header
                const AuthFormHeader(
                  title: 'Create Account',
                  subtitle: 'Sign up to get started',
                ),
                SizedBox(height: 40.h),

                // Register form
                RegisterForm(
                  formKey: _formKey,
                  nameController: _nameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  onRegister: _handleRegister,
                  onNavigateToLogin: _navigateToLogin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
