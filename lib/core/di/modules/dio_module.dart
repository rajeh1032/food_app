import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../api manager/api_endpoints.dart';
import '../di.dart';

/// Dio module for dependency injection
@module
abstract class DioModule {
  @lazySingleton
  Dio provideDio() {
    Dio dio = Dio();

    // Base configuration
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    dio.options.baseUrl = ApiEndpoints.mealDbBaseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    // Add interceptors
    dio.interceptors.add(getIt<PrettyDioLogger>());

    return dio;
  }

  @lazySingleton
  PrettyDioLogger providePrettyDioLogger() {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    );
  }
}
