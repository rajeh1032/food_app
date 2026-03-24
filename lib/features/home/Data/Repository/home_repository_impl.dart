import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/model/failures.dart';
import '../../Domain/Entity/home_category_entity.dart';
import '../../Domain/Entity/home_ingredient_entity.dart';
import '../../Domain/Entity/home_meal_entity.dart';
import '../../Domain/Repository/home_repository.dart';
import '../Data Sources/remote/home_remote_data_source.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl({required this.homeRemoteDataSource});

  @override
  Future<Either<Failures, List<HomeIngredientEntity>>> getIngredients() async {
    final either = await homeRemoteDataSource.getIngredients();
    return either.fold((error) => Left(error), (response) => Right(response));
  }

  @override
  Future<Either<Failures, List<HomeCategoryEntity>>> getCategories() async {
    final either = await homeRemoteDataSource.getCategories();
    return either.fold((error) => Left(error), (response) => Right(response));
  }

  @override
  Future<Either<Failures, List<HomeMealEntity>>> getMealsByIngredient(
    String ingredient,
  ) async {
    final either = await homeRemoteDataSource.getMealsByIngredient(ingredient);
    return either.fold((error) => Left(error), (response) => Right(response));
  }

  @override
  Future<Either<Failures, List<HomeMealEntity>>> getMealsByCategory(
    String category,
  ) async {
    final either = await homeRemoteDataSource.getMealsByCategory(category);
    return either.fold((error) => Left(error), (response) => Right(response));
  }
}
