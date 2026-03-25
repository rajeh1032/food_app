import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/di/di.dart';
import 'core/routes/routes.dart';
import 'core/routes/route_names.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/my_bloc_observer.dart';
import 'core/utils/shared_pref_services.dart';
import 'features/saved/Data/Models/saved_meal_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  // Initialize SharedPreferences
  await SharedPrefService.instance.init();

  // ── Initialize Hive ────────────────────────────────────────────────────────
  await Hive.initFlutter();
  Hive.registerAdapter(SavedMealModelAdapter()); // ← register adapter
  // NOTE: Don't open the box here — it's opened per-user in RootScreen.initState()
  // ──────────────────────────────────────────────────────────────────────────

  // Initialize HydratedBloc storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  // Set BLoC observer for debugging
  Bloc.observer = MyBlocObserver();

  // Configure dependency injection
  configureDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Recipe App',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppTheme.lightTheme,
          routes: Routes.myAppRoutes,
          onGenerateRoute: Routes.onGenerateRoute,
          initialRoute: RouteNames.splash,
        );
      },
    );
  }
}