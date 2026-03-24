import '../../Domain/Entity/home_category_entity.dart';
import '../../Domain/Entity/home_ingredient_entity.dart';
import '../../Domain/Entity/home_meal_entity.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeErrorState extends HomeStates {
  final String message;

  HomeErrorState({required this.message});
}

class HomeSuccessState extends HomeStates {
  final List<HomeIngredientEntity> ingredients;
  final List<HomeCategoryEntity> categories;
  final List<HomeMealEntity> allMeals;
  final List<HomeMealEntity> meals;
  final String selectedIngredient;
  final String selectedCategory;
  final bool isLoadingMeals;
  final bool isLoadingMoreMeals;
  final int currentPage;
  final bool hasMoreMeals;

  HomeSuccessState({
    required this.ingredients,
    required this.categories,
    required this.allMeals,
    required this.meals,
    required this.selectedIngredient,
    required this.selectedCategory,
    this.isLoadingMeals = false,
    this.isLoadingMoreMeals = false,
    this.currentPage = 1,
    this.hasMoreMeals = false,
  });

  HomeSuccessState copyWith({
    List<HomeIngredientEntity>? ingredients,
    List<HomeCategoryEntity>? categories,
    List<HomeMealEntity>? allMeals,
    List<HomeMealEntity>? meals,
    String? selectedIngredient,
    String? selectedCategory,
    bool? isLoadingMeals,
    bool? isLoadingMoreMeals,
    int? currentPage,
    bool? hasMoreMeals,
  }) {
    return HomeSuccessState(
      ingredients: ingredients ?? this.ingredients,
      categories: categories ?? this.categories,
      allMeals: allMeals ?? this.allMeals,
      meals: meals ?? this.meals,
      selectedIngredient: selectedIngredient ?? this.selectedIngredient,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoadingMeals: isLoadingMeals ?? this.isLoadingMeals,
      isLoadingMoreMeals: isLoadingMoreMeals ?? this.isLoadingMoreMeals,
      currentPage: currentPage ?? this.currentPage,
      hasMoreMeals: hasMoreMeals ?? this.hasMoreMeals,
    );
  }
}
