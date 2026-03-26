import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/details/cubit/states.dart';
import '../models/meal_model.dart';
import '../repository/meal_repository.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final MealRepository repo;

  DetailsCubit(this.repo) : super(DetailsInitial());

  Future<void> getMealDetails(String id) async {
    emit(DetailsLoading());

    try {
      final meal = await repo.fetchMealDetails(id);
      emit(DetailsSuccess(meal));
    } catch (e) {
      emit(DetailsError(e.toString()));
    }
  }
}