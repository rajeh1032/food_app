import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../repository/meal_repository.dart';
import '../../services/api_service.dart';
import '../widgets/author_row.dart';
import '../widgets/description_text.dart';
import '../widgets/hero_image.dart';
import '../widgets/ingredients_list.dart';
import '../widgets/section_title.dart';
import '../widgets/watch_video_button.dart';

class RecipeDetailPage extends StatelessWidget {
  final String mealId;

  const RecipeDetailPage({
    super.key,
    required this.mealId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailsCubit(
        MealRepository(ApiService()),
      )..getMealDetails(mealId),
      child: const _RecipeDetailView(),
    );
  }
}

class _RecipeDetailView extends StatelessWidget {
  const _RecipeDetailView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {

          if (state is DetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is DetailsError) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is DetailsSuccess) {

            final meal = state.meal;

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      HeroImage(
                        imgUrl: meal.thumb,
                      ),

                      Padding(
                        padding:
                        EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 16.h),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    meal.name,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),

                                SizedBox(width: 8.w),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.star_rounded, color: Color(0xFFFFC107), size: 18),
                                    SizedBox(width: 4.w),
                                    Text(
                                      '(4.5)',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),

                            AuthorRow(),

                            SizedBox(height: 20.h),

                            const SectionTitle(
                                title: 'Description'),

                            SizedBox(height: 8.h),
                            ExpandableText(text: meal.instructions) ,

                            SizedBox(height: 20.h),

                            const SectionTitle(
                                title: 'Ingredients'),

                            SizedBox(height: 10.h),

                            IngredientsList(
                              ingredients:
                              meal.ingredients,
                              measures:
                              meal.measures,
                            ),

                            SizedBox(height: 80.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: 28.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: WatchVideoButton(
                      youtubeUrl:
                      meal.youtube ?? '',
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

