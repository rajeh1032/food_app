import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../Domain/Entity/home_category_entity.dart';
import '../../Domain/Entity/home_ingredient_entity.dart';
import '../../Domain/Entity/home_meal_entity.dart';
import '../../Domain/Use Case/home_use_case.dart';
import 'home_states.dart';

@injectable
class HomeViewModel extends HydratedCubit<HomeStates> {
  final HomeUseCase homeUseCase;
  static const int _pageSize = 5;

  HomeViewModel({required this.homeUseCase}) : super(HomeInitialState());

  static const List<String> _preferredIngredients = [
    'Chicken',
    'Salmon',
    'Beef',
    'Pork',
    'Avocado',
    'Apple Cider Vinegar',
    'Asparagus',
    'Aubergine',
    'Baby Plum Tomatoes',
    'Bacon',
    'Baking Powder',
    'Balsamic Vinegar',
    'Black Treacle',
    'Borlotti Beans',
    'Bramley Apples',
    'Bread',
    'Shrimp',
    'Octopus',
    'Fish',
    'Broccoli',
    'Egg',
    'Cucumber',
  ];

  Future<void> initializeHome() async {
    if (state is HomeSuccessState) {
      final currentState = state as HomeSuccessState;
      if (currentState.ingredients.length == _preferredIngredients.length) {
        return;
      }
    }

    emit(HomeLoadingState());

    final ingredientsResult = await homeUseCase.getIngredientsInvoke();
    if (ingredientsResult.isLeft) {
      emit(HomeErrorState(message: ingredientsResult.left.errorMessage));
      return;
    }

    final categoriesResult = await homeUseCase.getCategoriesInvoke();
    if (categoriesResult.isLeft) {
      emit(HomeErrorState(message: categoriesResult.left.errorMessage));
      return;
    }

    final ingredients = _getVisibleIngredients(ingredientsResult.right);
    final categories = [
      HomeCategoryEntity(strCategory: 'All'),
      ...categoriesResult.right,
    ];
    final selectedIngredient = ingredients.isNotEmpty
        ? (ingredients.first.strIngredient ?? 'Chicken')
        : 'Chicken';

    final mealsResult = await homeUseCase.getMealsByIngredientInvoke(
      selectedIngredient,
    );
    if (mealsResult.isLeft) {
      emit(HomeErrorState(message: mealsResult.left.errorMessage));
      return;
    }

    emit(
      _buildPaginatedState(
        ingredients: ingredients,
        categories: categories,
        allMeals: mealsResult.right,
        selectedIngredient: selectedIngredient,
        selectedCategory: 'All',
      ),
    );
  }

  Future<void> refreshHome() async {
    emit(HomeInitialState());
    await initializeHome();
  }

  Future<void> selectIngredient(String ingredient) async {
    if (state is! HomeSuccessState) return;
    final currentState = state as HomeSuccessState;

    emit(
      currentState.copyWith(
        selectedIngredient: ingredient,
        selectedCategory: 'All',
        isLoadingMeals: true,
      ),
    );

    final mealsResult = await homeUseCase.getMealsByIngredientInvoke(
      ingredient,
    );
    mealsResult.fold(
      (failure) => emit(HomeErrorState(message: failure.errorMessage)),
      (meals) => emit(
        _buildPaginatedState(
          ingredients: currentState.ingredients,
          categories: currentState.categories,
          allMeals: meals,
          selectedIngredient: ingredient,
          selectedCategory: 'All',
        ),
      ),
    );
  }

  Future<void> searchByIngredient(String ingredient) async {
    final normalizedIngredient = ingredient.trim();
    if (normalizedIngredient.isEmpty) {
      await refreshHome();
      return;
    }

    if (state is! HomeSuccessState) {
      await initializeHome();
    }
    if (state is! HomeSuccessState) return;

    final currentState = state as HomeSuccessState;

    emit(
      currentState.copyWith(
        selectedIngredient: normalizedIngredient,
        selectedCategory: 'All',
        isLoadingMeals: true,
      ),
    );

    final mealsResult = await homeUseCase.getMealsByIngredientInvoke(
      normalizedIngredient,
    );
    mealsResult.fold(
      (failure) => emit(HomeErrorState(message: failure.errorMessage)),
      (meals) => emit(
        _buildPaginatedState(
          ingredients: currentState.ingredients,
          categories: currentState.categories,
          allMeals: meals,
          selectedIngredient: normalizedIngredient,
          selectedCategory: 'All',
        ),
      ),
    );
  }

  Future<void> selectCategory(String category) async {
    if (state is! HomeSuccessState) return;
    final currentState = state as HomeSuccessState;

    emit(
      currentState.copyWith(selectedCategory: category, isLoadingMeals: true),
    );

    if (category == 'All') {
      final mealsResult = await homeUseCase.getMealsByIngredientInvoke(
        currentState.selectedIngredient,
      );
      mealsResult.fold(
        (failure) => emit(HomeErrorState(message: failure.errorMessage)),
        (meals) => emit(
          _buildPaginatedState(
            ingredients: currentState.ingredients,
            categories: currentState.categories,
            allMeals: meals,
            selectedIngredient: currentState.selectedIngredient,
            selectedCategory: 'All',
          ),
        ),
      );
      return;
    }

    final mealsResult = await homeUseCase.getMealsByCategoryInvoke(category);
    mealsResult.fold(
      (failure) => emit(HomeErrorState(message: failure.errorMessage)),
      (meals) => emit(
        _buildPaginatedState(
          ingredients: currentState.ingredients,
          categories: currentState.categories,
          allMeals: meals,
          selectedIngredient: currentState.selectedIngredient,
          selectedCategory: category,
        ),
      ),
    );
  }

  void loadMoreMeals() {
    if (state is! HomeSuccessState) return;
    final currentState = state as HomeSuccessState;

    if (!currentState.hasMoreMeals || currentState.isLoadingMoreMeals) return;

    emit(currentState.copyWith(isLoadingMoreMeals: true));

    final nextPage = currentState.currentPage + 1;
    final nextMeals = _getPaginatedMeals(currentState.allMeals, nextPage);

    emit(
      currentState.copyWith(
        meals: nextMeals,
        currentPage: nextPage,
        hasMoreMeals: nextMeals.length < currentState.allMeals.length,
        isLoadingMoreMeals: false,
      ),
    );
  }

  HomeSuccessState _buildPaginatedState({
    required List<HomeIngredientEntity> ingredients,
    required List<HomeCategoryEntity> categories,
    required List<HomeMealEntity> allMeals,
    required String selectedIngredient,
    required String selectedCategory,
  }) {
    final paginatedMeals = _getPaginatedMeals(allMeals, 1);

    return HomeSuccessState(
      ingredients: ingredients,
      categories: categories,
      allMeals: allMeals,
      meals: paginatedMeals,
      selectedIngredient: selectedIngredient,
      selectedCategory: selectedCategory,
      isLoadingMeals: false,
      currentPage: 1,
      hasMoreMeals: paginatedMeals.length < allMeals.length,
    );
  }

  List<HomeMealEntity> _getPaginatedMeals(
    List<HomeMealEntity> allMeals,
    int page,
  ) {
    final endIndex = (page * _pageSize).clamp(0, allMeals.length);
    return allMeals.take(endIndex).toList();
  }

  List<HomeIngredientEntity> _getVisibleIngredients(
    List<HomeIngredientEntity> ingredients,
  ) {
    final preferred = <HomeIngredientEntity>[];

    for (final ingredientName in _preferredIngredients) {
      final match = ingredients.where((ingredient) {
        return (ingredient.strIngredient ?? '').toLowerCase() ==
            ingredientName.toLowerCase();
      });

      if (match.isNotEmpty) {
        preferred.add(match.first);
      }
    }

    return preferred;
  }

  @override
  HomeStates? fromJson(Map<String, dynamic> json) {
    try {
      if (json['state'] == 'success') {
        final ingredients = (json['ingredients'] as List<dynamic>? ?? [])
            .map((ingredient) => HomeIngredientEntity.fromJson(ingredient))
            .toList();
        final categories = (json['categories'] as List<dynamic>? ?? [])
            .map((category) => HomeCategoryEntity.fromJson(category))
            .toList();
        final mealsJson = (json['meals'] as List<dynamic>? ?? []);
        final allMealsJson = (json['allMeals'] as List<dynamic>? ?? mealsJson);
        final meals =
            mealsJson.map((meal) => HomeMealEntity.fromJson(meal)).toList();
        final allMeals =
            allMealsJson.map((meal) => HomeMealEntity.fromJson(meal)).toList();

        return HomeSuccessState(
          ingredients: ingredients,
          categories: categories,
          allMeals: allMeals,
          meals: meals,
          selectedIngredient: json['selectedIngredient'] ?? 'Chicken',
          selectedCategory: json['selectedCategory'] ?? 'All',
          currentPage: json['currentPage'] ?? 1,
          hasMoreMeals: json['hasMoreMeals'] ?? false,
        );
      }
      return HomeInitialState();
    } catch (e) {
      return HomeInitialState();
    }
  }

  @override
  Map<String, dynamic>? toJson(HomeStates state) {
    if (state is HomeSuccessState) {
      return {
        'state': 'success',
        'ingredients':
            state.ingredients.map((ingredient) => ingredient.toJson()).toList(),
        'categories':
            state.categories.map((category) => category.toJson()).toList(),
        'allMeals': state.allMeals.map((meal) => meal.toJson()).toList(),
        'meals': state.meals.map((meal) => meal.toJson()).toList(),
        'selectedIngredient': state.selectedIngredient,
        'selectedCategory': state.selectedCategory,
        'currentPage': state.currentPage,
        'hasMoreMeals': state.hasMoreMeals,
      };
    }
    return null;
  }
}
