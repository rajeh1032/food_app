// import 'package:get_it/get_it.dart';
// import 'package:injectable/injectable.dart';
// import 'di.config.dart';
//
// final getIt = GetIt.instance;
//
// @InjectableInit(
//   initializerName: 'init',
//   preferRelativeImports: true,
//   asExtension: true,
// )
// void configureDependencies() => getIt.init();



import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../features/home/Data/Data Sources/remote/home_remote_data_source.dart';
import '../../features/home/Data/Data Sources/remote/impl/home_remote_data_source_impl.dart';
import '../../features/home/Data/Repository/home_repository_impl.dart';
import '../../features/home/Domain/Repository/home_repository.dart';
import '../../features/home/Domain/Use Case/home_use_case.dart';
import '../../features/home/ui/cubit/home_view_model.dart';

import '../api manager/api_manager.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() {
  // -------------------- Dio --------------------
  // تسجيل الـ Dio
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<PrettyDioLogger>(() => PrettyDioLogger());

// تسجيل ApiManager
  getIt.registerLazySingleton<ApiManager>(() => ApiManager(getIt<Dio>()));

// تسجيل HomeRemoteDataSource
  getIt.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(apiManager: getIt<ApiManager>()),
  );

// تسجيل HomeRepository مع الـ RemoteDataSource
  getIt.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(homeRemoteDataSource: getIt<HomeRemoteDataSource>()),
  );

// تسجيل UseCase
  getIt.registerLazySingleton<HomeUseCase>(
        () => HomeUseCase(homeRepository: getIt<HomeRepository>()),
  );

// تسجيل ViewModel
  getIt.registerLazySingleton<HomeViewModel>(
        () => HomeViewModel(homeUseCase: getIt<HomeUseCase>()),
  );
}