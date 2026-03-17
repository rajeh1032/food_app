import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/assets/app_assets.dart';
import '../../../../core/di/di.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
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
  final ScrollController mealsScrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

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
    mealsScrollController.addListener(_onMealsScroll);
    viewModel.initializeHome();
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
    return BlocProvider.value(
      value: viewModel,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBgColor,
        body: SafeArea(
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
              final topIngredients = _topIngredients(successState.ingredients);
              final bottomIngredients = _bottomIngredients(
                successState.ingredients,
              );

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeGreetingHeader(
                      avatarAssetPath: AppAssets.userImage,
                      greeting: 'Welcome, 👋🏻',
                      userName: 'Tasya Aulianza',
                    ),
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
                          _buildIngredientRow(bottomIngredients, successState),
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
                      SizedBox(
                        height: 280.h,
                        child: ListView.separated(
                          controller: mealsScrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: successState.meals.length +
                              (successState.hasMoreMeals ||
                                      successState.isLoadingMoreMeals
                                  ? 1
                                  : 0),
                          separatorBuilder: (_, __) => SizedBox(width: 12.w),
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
                            return HomeMealCard(
                              imageUrl: meal.strMealThumb ?? '',
                              title: meal.strMeal ?? '',
                              timeLabel: _getRandomTimeLabel(
                                meal.idMeal ?? meal.strMeal ?? '',
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
