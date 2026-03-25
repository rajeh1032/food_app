// ─── Add these lines inside your setupDI() / initDependencies() ──────────────
//
// 1. Register the Hive adapter once in main.dart (before runApp):
//
//    Hive.registerAdapter(SavedMealModelAdapter());
//
// 2. Open the box for the logged-in user right after login/register succeeds:
//
//    await SavedLocalDataSourceImpl.openBoxForUser(userId);
//
// 3. Add to getIt registrations:

/*
  // ── Saved feature ───────────────────────────────────────────────────────

  getIt.registerLazySingleton<SavedLocalDataSource>(
    () => SavedLocalDataSourceImpl(),
  );

  getIt.registerLazySingleton<SavedRepository>(
    () => SavedRepositoryImpl(getIt<SavedLocalDataSource>()),
  );

  getIt.registerLazySingleton(() => GetSavedMealsUseCase(getIt<SavedRepository>()));
  getIt.registerLazySingleton(() => SaveMealUseCase(getIt<SavedRepository>()));
  getIt.registerLazySingleton(() => RemoveMealUseCase(getIt<SavedRepository>()));
  getIt.registerLazySingleton(() => IsMealSavedUseCase(getIt<SavedRepository>()));

  getIt.registerLazySingleton<SavedViewModel>(
    () => SavedViewModel(
      getSavedMeals: getIt<GetSavedMealsUseCase>(),
      saveMeal:      getIt<SaveMealUseCase>(),
      removeMeal:    getIt<RemoveMealUseCase>(),
      isMealSaved:   getIt<IsMealSavedUseCase>(),
    ),
  );
*/