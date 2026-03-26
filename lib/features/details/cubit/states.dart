import '../models/meal_model.dart';

abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsSuccess extends DetailsState {
  final Meal meal;

  DetailsSuccess(this.meal);
}

class DetailsError extends DetailsState {
  final String message;

  DetailsError(this.message);
}