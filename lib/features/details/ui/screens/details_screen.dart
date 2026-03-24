//
// import 'package:flutter/material.dart';
//
// import '../widgets/author_row.dart';
// import '../widgets/hero_image.dart';
// import '../widgets/section_title.dart';
// import '../widgets/watch_video_button.dart';
//
// class RecipeDetailPage extends StatelessWidget {
//   const RecipeDetailPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // ─── Hero Image ───────────────────────────────────────────
//                 HeroImage(imgUrl: 'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg'),
//
//                 // ─── Content ──────────────────────────────────────────────
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Title + Rating
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Spiced Fried Chicken',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w700,
//                               color: Color(0xFF1A1A1A),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               const Icon(Icons.star_rounded,
//                                   color: Color(0xFFFFC107), size: 18),
//                               const SizedBox(width: 4),
//                               Text(
//                                 '(4.5)',
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.grey[600],
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(height: 12),
//
//                       // Author Row
//                       AuthorRow(),
//
//                       const SizedBox(height: 20),
//
//                       const SectionTitle(title: 'Description'),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Indonesian Fried Chicken or Ayam Goreng, is a delicious and popular dish that showcases the vibrant flavors of Indonesian cuisine.',
//                         style: TextStyle(
//                           fontSize: 13.5,
//                           color: Colors.grey[700],
//                           height: 1.6,
//                         ),
//                       ),
//
//                       const SizedBox(height: 20),
//                       const SectionTitle(title: 'Ingredients'),
//                       const SizedBox(height: 10),
//                       _IngredientsList(),
//
//                       // Extra space so FAB doesn't cover last item
//                       const SizedBox(height: 80),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // ─── Watch Video FAB ────────────────────────────────────────────
//           Positioned(
//             bottom: 28,
//             left: 0,
//             right: 0,
//             child: Center(child: WatchVideoButton()),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class _IngredientsList extends StatelessWidget {
//   final _ingredients = const [
//     '300 grams of egg noodles, boiled until tender',
//     '6 tbsp onion chicken oil',
//     '3 tsp soy sauce',
//     '2 bunches of mustard greens, dipped briefly in boiling water, set aside',
//     '250 grams chicken meat, sliced',
//     '6 pieces of boiled feet',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: _ingredients
//           .map((item) => Padding(
//         padding: const EdgeInsets.only(bottom: 10),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 6),
//               child: Container(
//                 width: 7,
//                 height: 7,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Color(0xFF1A1A1A),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Text(
//                 item,
//                 style: TextStyle(
//                   fontSize: 13.5,
//                   color: Colors.grey[700],
//                   height: 1.5,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ))
//           .toList(),
//     );
//   }
// }
//


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../repository/meal_repository.dart';
import '../../services/api_service.dart';
import '../widgets/author_row.dart';
import '../widgets/hero_image.dart';
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

          /// 🟡 Loading
          if (state is DetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// 🔴 Error
          if (state is DetailsError) {
            return Center(
              child: Text(state.message),
            );
          }

          /// 🟢 Success
          if (state is DetailsSuccess) {

            final meal = state.meal;

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      /// Hero Image
                      HeroImage(
                        imgUrl: meal.thumb,
                      ),

                      /// Content
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            /// Title
                            Text(
                              meal.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 12),

                            AuthorRow(),

                            const SizedBox(height: 20),

                            const SectionTitle(
                                title: 'Description'),

                            const SizedBox(height: 8),

                            Text(
                              meal.instructions,
                              style: TextStyle(
                                fontSize: 13.5,
                                color:
                                Colors.grey[700],
                                height: 1.6,
                              ),
                            ),

                            const SizedBox(height: 20),

                            const SectionTitle(
                                title: 'Ingredients'),

                            const SizedBox(height: 10),

                            IngredientsList(
                              ingredients:
                              meal.ingredients,
                              measures:
                              meal.measures,
                            ),

                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: 28,
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

class IngredientsList extends StatelessWidget {

  final List<String> ingredients;
  final List<String> measures;

  const IngredientsList({
    super.key,
    required this.ingredients,
    required this.measures,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: List.generate(
        ingredients.length,
            (index) {

          final item =
              "${measures[index]} ${ingredients[index]}";

          return Padding(
            padding:
            const EdgeInsets.only(bottom: 10),

            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                /// bullet
                Padding(
                  padding:
                  const EdgeInsets.only(top: 6),

                  child: Container(
                    width: 7,
                    height: 7,
                    decoration:
                    const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}