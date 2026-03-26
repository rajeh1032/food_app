import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../repository/meal_repository.dart';
import '../../services/api_service.dart';
import '../../../saved/ui/Cubit/saved_states.dart';
import '../../../saved/ui/Cubit/saved_view_model.dart';
import '../widgets/author_row.dart';
import '../widgets/description_text.dart';
import '../widgets/hero_image.dart';
import '../widgets/ingredients_list.dart';
import '../widgets/section_title.dart';
import '../widgets/watch_video_button.dart';

class RecipeDetailPage extends StatefulWidget {
  final String mealId;

  const RecipeDetailPage({
    super.key,
    required this.mealId,
  });

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late final SavedViewModel _savedViewModel;
  late final String _userId;

  @override
  void initState() {
    super.initState();
    _savedViewModel = getIt<SavedViewModel>();
    _userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest';
    _savedViewModel.loadSavedMeals(_userId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _savedViewModel),
        BlocProvider(
          create:
              (_) => DetailsCubit(
                MealRepository(ApiService()),
              )..getMealDetails(widget.mealId),
        ),
      ],
      child: _RecipeDetailView(userId: _userId),
    );
  }
}

class _RecipeDetailView extends StatelessWidget {
  final String userId;

  const _RecipeDetailView({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<SavedViewModel, SavedState>(
        listenWhen: (_, current) => current is SavedErrorState,
        listener: (context, state) {
          if (state is SavedErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<DetailsCubit, DetailsState>(
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

              return BlocBuilder<SavedViewModel, SavedState>(
                buildWhen:
                    (_, current) =>
                        current is SavedLoadingState ||
                        current is SavedSuccessState ||
                        current is BookmarkToggledState ||
                        current is SavedErrorState,
                builder: (context, _) {
                  final savedViewModel = context.read<SavedViewModel>();
                  final isSaved = savedViewModel.isSaved(meal.id);

                  return Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeroImage(
                              imgUrl: meal.thumb,
                              isSaved: isSaved,
                              onBookmarkTap:
                                  meal.id.isEmpty
                                      ? null
                                      : () => savedViewModel.toggleBookmark(
                                        userId: userId,
                                        mealId: meal.id,
                                        mealName: meal.name,
                                        mealThumb: meal.thumb,
                                        rating: '4.5',
                                        time: '30 min',
                                        views: '',
                                      ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 16.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          const Icon(
                                            Icons.star_rounded,
                                            color: Color(0xFFFFC107),
                                            size: 18,
                                          ),
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
                                  const SectionTitle(title: 'Description'),
                                  SizedBox(height: 8.h),
                                  ExpandableText(text: meal.instructions),
                                  SizedBox(height: 20.h),
                                  const SectionTitle(title: 'Ingredients'),
                                  SizedBox(height: 10.h),
                                  IngredientsList(
                                    ingredients: meal.ingredients,
                                    measures: meal.measures,
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
                            youtubeUrl: meal.youtube ?? '',
                            measures: meal.measures,
                            ingredients: meal.ingredients,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

