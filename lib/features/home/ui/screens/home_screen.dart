import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../saved/Data/Data Sources/saved_local_data_source.dart';
import '../../../saved/ui/Cubit/saved_states.dart';
import '../../../saved/ui/Cubit/saved_view_model.dart';
import '../../../search/ui/cubit/search_cubit.dart';
import '../../../search/ui/models/meal_model.dart';
import '../../Domain/Entity/home_ingredient_entity.dart';
import '../cubit/home_states.dart';
import '../cubit/home_view_model.dart';
import '../widgets/home_greeting_header.dart';
import '../widgets/home_ingredient_chip.dart';
import '../widgets/home_meal_card.dart';
import '../widgets/home_recipe_tab.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/home_section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel viewModel = getIt<HomeViewModel>();
  final SavedViewModel savedViewModel = getIt<SavedViewModel>();
  final ScrollController mealsScrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  late final String _userId;

  static const Map<String, String> _ingredientEmojis = {
    'Chicken': '🐔',
    'Salmon': '🐟',
    'Beef': '🥩',
    'Pork': '🥓',
    'Avocado': '🥑',
    'Apple Cider Vinegar': '🍎',
    'Asparagus': '🥬',
    'Aubergine': '🍆',
    'Baby Plum Tomatoes': '🍅',
    'Bacon': '🥓',
    'Baking Powder': '🧁',
    'Balsamic Vinegar': '🍶',
    'Black Treacle': '🍯',
    'Borlotti Beans': '🫘',
    'Bramley Apples': '🍏',
    'Bread': '🍞',
    'Shrimp': '🍤',
    'Octopus': '🐙',
    'Fish': '🐟',
    'Broccoli': '🥦',
    'Egg': '🥚',
    'Cucumber': '🥒',
  };

  @override
  void initState() {
    super.initState();
    _userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest';
    mealsScrollController.addListener(_onMealsScroll);
    viewModel.initializeHome();
    _initializeSavedMeals();
  }

  Future<void> _initializeSavedMeals() async {
    await SavedLocalDataSourceImpl.openBoxForUser(_userId);
    await savedViewModel.preloadSavedIds(_userId);

    if (mounted) {
      setState(() {});
    }
  }

  void _onMealsScroll() {
    if (!mealsScrollController.hasClients) return;

    final position = mealsScrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      viewModel.loadMoreMeals();
    }
  }

  String _getRandomTimeLabel(String mealId) {
    final parsedId = int.tryParse(mealId) ?? mealId.hashCode.abs();
    final minutes = 15 + (parsedId % 46);
    return '$minutes min';
  }

  Future<void> _searchIngredient() async {
    FocusScope.of(context).unfocus();
    await viewModel.searchByIngredient(searchController.text);
  }

  List<HomeIngredientEntity> _topIngredients(List<HomeIngredientEntity> items) {
    final splitIndex = (items.length / 2).ceil();
    return items.take(splitIndex).toList();
  }

  List<HomeIngredientEntity> _bottomIngredients(
    List<HomeIngredientEntity> items,
  ) {
    final splitIndex = (items.length / 2).ceil();
    return items.skip(splitIndex).toList();
  }

  Widget _buildIngredientRow(
    List<HomeIngredientEntity> ingredients,
    HomeSuccessState successState,
  ) {
    return Row(
      children: List.generate(ingredients.length, (index) {
        final ingredient = ingredients[index];
        final label = ingredient.strIngredient ?? '';

        return Padding(
          padding: EdgeInsets.only(
              right: index == ingredients.length - 1 ? 0 : 10.w),
          child: GestureDetector(
            onTap: () => viewModel.selectIngredient(label),
            child: HomeIngredientChip(
              emoji: _ingredientEmojis[label] ?? '🍽️',
              label: label,
              isSelected: successState.selectedIngredient == label &&
                  successState.selectedCategory == 'All',
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    mealsScrollController
      ..removeListener(_onMealsScroll)
      ..dispose();
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: viewModel),
          BlocProvider.value(value: savedViewModel),
        ],
        child: Scaffold(
        backgroundColor: AppColors.scaffoldBgColor,
        body: BlocListener<SavedViewModel, SavedState>(
          listenWhen: (_, current) =>
              current is BookmarkToggledState || current is SavedErrorState,
          listener: (context, state) {
            if (state is BookmarkToggledState) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.primaryColor,
                    content: Text(
                      state.isSaved
                          ? 'Recipe saved successfully'
                          : 'Recipe removed from saved',
                    ),
                  ),
                );
            }

            if (state is SavedErrorState) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.errorColor,
                  ),
                );
            }
          },
          child: SafeArea(
            child: BlocBuilder<HomeViewModel, HomeStates>(
              builder: (context, state) {
                if (state is HomeLoadingState || state is HomeInitialState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is HomeErrorState) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: AppStyles.bodyMedium,
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: viewModel.refreshHome,
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final successState = state as HomeSuccessState;
                final topIngredients =
                    _topIngredients(successState.ingredients);
                final bottomIngredients = _bottomIngredients(
                  successState.ingredients,
                );

                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeGreetingHeader(),
                      SizedBox(height: 24.h),
                      HomeSearchBar(
                        hintText: 'Type ingredients...',
                        controller: searchController,
                        onSearch: _searchIngredient,
                        onSubmitted: (_) => _searchIngredient(),
                      ),
                      SizedBox(height: 24.h),
                      const HomeSectionHeader(title: "What's in your fridge?"),
                      SizedBox(height: 16.h),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildIngredientRow(topIngredients, successState),
                            SizedBox(height: 8.h),
                            _buildIngredientRow(
                                bottomIngredients, successState),
                          ],
                        ),
                      ),
                      SizedBox(height: 32.h),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: successState.categories.map((category) {
                            final label = category.strCategory ?? '';
                            return GestureDetector(
                              onTap: () => viewModel.selectCategory(label),
                              child: HomeRecipeTab(
                                label: label,
                                isSelected:
                                    successState.selectedCategory == label,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              successState.selectedCategory == 'All'
                                  ? 'Meals with ${successState.selectedIngredient}'
                                  : '${successState.selectedCategory} meals',
                              style: AppStyles.titleLarge.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (successState.isLoadingMeals)
                            SizedBox(
                              width: 18.w,
                              height: 18.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      if (successState.meals.isEmpty)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            'No meals found for this filter.',
                            style: AppStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        )
                      else
                        BlocBuilder<SavedViewModel, SavedState>(
                          buildWhen: (_, current) =>
                              current is BookmarkToggledState ||
                              current is SavedSuccessState ||
                              current is SavedErrorState,
                          builder: (context, _) {
                            return SizedBox(
                              height: 260.h,
                              child: ListView.separated(
                                controller: mealsScrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: successState.meals.length +
                                    (successState.hasMoreMeals ||
                                            successState.isLoadingMoreMeals
                                        ? 1
                                        : 0),
                                separatorBuilder: (_, __) =>
                                    SizedBox(width: 12.w),
                                itemBuilder: (context, index) {
                                  if (index >= successState.meals.length) {
                                    return SizedBox(
                                      width: 72.w,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    );
                                  }

                                  final meal = successState.meals[index];
                                  final mealId =
                                      meal.idMeal ?? meal.strMeal ?? '';

                                  return HomeMealCard(
                                    imageUrl: meal.strMealThumb ?? '',
                                    mealId: mealId,
                                    title: meal.strMeal ?? '',
                                    timeLabel: _getRandomTimeLabel(mealId),
                                    isSaved: savedViewModel.isSaved(mealId),
                                    onTap: () {
                                      context.read<SearchCubit>().addToLastViewed(
                                        MealModel(
                                          idMeal: meal.idMeal,
                                          strMeal: meal.strMeal,
                                          strMealThumb: meal.strMealThumb,
                                        ),
                                      );
                                    },
                                    onFavoritePressed: mealId.isEmpty
                                        ? null
                                        : () => savedViewModel.toggleBookmark(
                                          userId: _userId,
                                          mealId: mealId,
                                          mealName: meal.strMeal ?? '',
                                          mealThumb: meal.strMealThumb ?? '',
                                          rating: '',
                                          time: _getRandomTimeLabel(mealId),
                                          views: '',
                                        ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
