import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/api manager/api_endpoints.dart';
import '../../../../../../core/api manager/api_manager.dart';
import '../../../../../../core/model/failures.dart';
import '../../../../Domain/Entity/home_category_entity.dart';
import '../../../../Domain/Entity/home_ingredient_entity.dart';
import '../../../../Domain/Entity/home_meal_entity.dart';
import '../../../Models/home_category_dm.dart';
import '../../../Models/home_ingredient_dm.dart';
import '../../../Models/home_meal_dm.dart';
import '../home_remote_data_source.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiManager apiManager;

  HomeRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, List<HomeIngredientEntity>>> getIngredients() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    try {
      if (_hasConnection(connectivityResult)) {
        final response = await apiManager.getData(
          path: ApiEndpoints.listIngredients,
          options: Options(validateStatus: (status) => true),
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final ingredients = (response.data['meals'] as List<dynamic>? ?? [])
              .map((ingredient) => HomeIngredientDm.fromJson(ingredient))
              .toList();
          return Right(ingredients);
        }

        return Left(
          ServerError(errorMessage: 'Failed to load ingredients list'),
        );
      } else {
        return Left(NetworkError(errorMessage: 'Network Error'));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<HomeCategoryEntity>>> getCategories() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    try {
      if (_hasConnection(connectivityResult)) {
        final response = await apiManager.getData(
          path: ApiEndpoints.listCategories,
          options: Options(validateStatus: (status) => true),
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final categories = (response.data['meals'] as List<dynamic>? ?? [])
              .map((category) => HomeCategoryDm.fromJson(category))
              .toList();
          return Right(categories);
        }

        return Left(ServerError(errorMessage: 'Failed to load categories'));
      } else {
        return Left(NetworkError(errorMessage: 'Network Error'));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<HomeMealEntity>>> getMealsByIngredient(
    String ingredient,
  ) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    try {
      if (_hasConnection(connectivityResult)) {
        final response = await apiManager.getData(
          path: ApiEndpoints.filterByIngredient,
          queryParameters: {'i': ingredient},
          options: Options(validateStatus: (status) => true),
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final meals = (response.data['meals'] as List<dynamic>? ?? [])
              .map((meal) => HomeMealDm.fromJson(meal))
              .toList();
          return Right(meals);
        }

        return Left(
          ServerError(
            errorMessage: 'Failed to load meals for ingredient $ingredient',
          ),
        );
      } else {
        return Left(NetworkError(errorMessage: 'Network Error'));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<HomeMealEntity>>> getMealsByCategory(
    String category,
  ) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    try {
      if (_hasConnection(connectivityResult)) {
        final response = await apiManager.getData(
          path: ApiEndpoints.filterByCategory,
          queryParameters: {'c': category},
          options: Options(validateStatus: (status) => true),
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final meals = (response.data['meals'] as List<dynamic>? ?? [])
              .map((meal) => HomeMealDm.fromJson(meal))
              .toList();
          return Right(meals);
        }

        return Left(
          ServerError(
            errorMessage: 'Failed to load meals for category $category',
          ),
        );
      } else {
        return Left(NetworkError(errorMessage: 'Network Error'));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  bool _hasConnection(List<ConnectivityResult> connectivityResult) {
    return connectivityResult.any(
      (result) => result != ConnectivityResult.none,
    );
  }
}
