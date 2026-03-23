import 'package:flutter/material.dart';
import '../../features/root/root_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import 'route_names.dart';

/// Application routes configuration
abstract class Routes {
  static Map<String, Widget Function(BuildContext)> myAppRoutes = {
    // Splash
    RouteNames.splash: (_) => const SplashScreen(),

    // Onboarding
    RouteNames.onboarding: (_) => const OnboardingScreen(),

    // Root route with bottom navigation
    RouteNames.root: (_) => const RootScreen(),

    // Authentication routes - will be implemented later
    // RouteNames.login: (_) => LoginScreen(),
    // RouteNames.register: (_) => RegisterScreen(),

    // Recipe routes
    // RouteNames.recipeDetails: (_) => RecipeDetailsScreen(),
  };

  /// Generate route with arguments
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final builder = myAppRoutes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(builder: builder, settings: settings);
    }
    return null;
  }
}
