import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../details/ui/screens/details_screen.dart';
import '../../../../core/theme/app_styles.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_states.dart';
import '../models/meal_model.dart';

import '../widgets/search_field.dart';
import '../widgets/search_history.dart';
import '../widgets/last_viewed.dart';
import '../widgets/meals_grid.dart';
import '../widgets/section_header.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchView();

  }
}

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  bool showAllHistory = false;
  bool showAllViewed = false;

  Future<void> _openMealDetails(MealModel meal) async {
    final mealId = meal.idMeal;
    if (mealId == null || mealId.isEmpty) return;

    final searchCubit = context.read<SearchCubit>();
    await searchCubit.addToLastViewed(meal);
    await searchCubit.addToSearchHistory(meal);

    if (!mounted) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeDetailPage(mealId: mealId),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchCubit>().loadFromPrefs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SearchCubit>();

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),

              const SearchField(),

              SizedBox(height: 15.h),

              // Search History Section
              SectionHeader(
                title: "Search History",
                buttonText: showAllHistory ? "See Less" : "See All",
                onTap: () {
                  setState(() {
                    showAllHistory = !showAllHistory;
                  });
                },
              ),

              cubit.searchHistory.isEmpty
                  ? const Text("No search history")
                  : ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: showAllHistory
                    ? cubit.searchHistory.length
                    : cubit.searchHistory.take(3).length,
                itemBuilder: (context, index) {
                  final meal = cubit.searchHistory[index];

                  return SearchHistory(
                    title: meal.strMeal ?? "",
                    image: meal.strMealThumb ?? "",
                    rate: meal.rate,
                    isVertical: false,
                    onTap: () => _openMealDetails(meal),
                  );
                },
              ),

              SizedBox(height: 10.h),

              // Last Viewed Section
              SectionHeader(
                title: "Last Viewed",
                buttonText: showAllViewed ? "See Less" : "See All",
                onTap: () {
                  setState(() {
                    showAllViewed = !showAllViewed;
                  });
                },
              ),

              SizedBox(height: 5.h),

              cubit.lastViewed.isEmpty
                  ? const Text("No viewed meals yet")
                  : SizedBox(
                height: 160.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: showAllViewed
                      ? cubit.lastViewed.length
                      : cubit.lastViewed.take(3).length,
                  itemBuilder: (context, index) {
                    final meal = cubit.lastViewed[index];

                    return LastViewed(
                      title: meal.strMeal ?? "",
                      image: meal.strMealThumb ?? "",
                      rate: meal.rate,
                      onTap: () => _openMealDetails(meal),
                    );
                  },
                ),
              ),

              SizedBox(height: 15.h),

              Text(
                "Based on your search",
                style: AppStyles.headlineMedium,
              ),
              SizedBox(height: 15.h),

              BlocBuilder<SearchCubit, SearchStates>(
                builder: (context, state) {
                  if (state is SearchLoadingState) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.sp),
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is SearchErrorState) {
                    return Center(child: Text(state.error));
                  }

                  if (state is SearchSuccessState) {
                    if (state.meals.isEmpty) {
                      return const Center(child: Text("No meals found"));
                    }

                    return MealsGrid(meals: state.meals);
                  }

                  return const SizedBox();
                },
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
