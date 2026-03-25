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
import '../widgets/login_form.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final AuthViewModel viewModel = getIt<AuthViewModel>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      viewModel.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  void _navigateToRegister() {
    Navigator.pushReplacementNamed(context, RouteNames.register);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: viewModel,
      listener: (context, state) {
        if (state is AuthLoadingState) {
          DialogUtils.showLoading(context: context, message: 'Logging in...');
        } else if (state is AuthErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showError(
            context: context,
            message: state.message,
            title: 'Login Failed',
          );
        } else if (state is LoginSuccessState) {
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
                  title: 'Welcome Back',
                  subtitle: 'Login to continue to your account',
                ),
                SizedBox(height: 40.h),

                // Login form
                LoginForm(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  onLogin: _handleLogin,
                  onNavigateToRegister: _navigateToRegister,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
