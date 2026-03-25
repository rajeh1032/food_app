import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import 'home_network_image.dart';
import 'recipe_meta_item.dart';

class FeaturedRecipeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String rating;
  final String time;
  final String authorName;
  final String authorAvatarUrl;

  const FeaturedRecipeCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.time,
    required this.authorName,
    required this.authorAvatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeNetworkImage(
            imageUrl: imageUrl,
            width: 300.w,
            height: 158.h,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
            fallbackIcon: Icons.fastfood_rounded,
            fallbackIconSize: 40,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(19.w, 16.h, 19.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 22 / 18,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    RecipeMetaItem(
                      icon: Icons.star_rounded,
                      label: '($rating)',
                      iconColor: AppColors.ratingColor,
                    ),
                    SizedBox(width: 17.w),
                    RecipeMetaItem(
                      icon: Icons.access_time_rounded,
                      label: time,
                      iconColor: AppColors.timerColor,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    HomeNetworkImage(
                      imageUrl: authorAvatarUrl,
                      width: 28.w,
                      height: 28.w,
                      borderRadius: BorderRadius.circular(14.r),
                      fallbackIcon: Icons.person_rounded,
                      fallbackIconSize: 14,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        authorName,
                        style: AppStyles.labelLarge.copyWith(
                          color: AppColors.textPrimary,
                          height: 18 / 14,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.bookmark_rounded,
                      color: AppColors.primaryColor,
                      size: 18.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_styles.dart';
// import '../../../../core/di/di.dart';
// import '../../../saved/ui/Cubit/saved_states.dart';
// import '../../../saved/ui/Cubit/saved_view_model.dart';
// import 'home_network_image.dart';
// import 'recipe_meta_item.dart';
//
// class FeaturedRecipeCard extends StatefulWidget {
//   final String mealId;
//   final String imageUrl;
//   final String title;
//   final String rating;
//   final String time;
//   final String authorName;
//   final String authorAvatarUrl;
//
//   const FeaturedRecipeCard({
//     super.key,
//     required this.mealId,
//     required this.imageUrl,
//     required this.title,
//     required this.rating,
//     required this.time,
//     required this.authorName,
//     required this.authorAvatarUrl,
//   });
//
//   @override
//   State<FeaturedRecipeCard> createState() => _FeaturedRecipeCardState();
// }
//
// class _FeaturedRecipeCardState extends State<FeaturedRecipeCard> {
//   late final SavedViewModel _savedViewModel;
//   late final String _userId;
//
//   @override
//   void initState() {
//     super.initState();
//     _savedViewModel = getIt<SavedViewModel>();
//     _userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest';
//     _savedViewModel.preloadSavedIds(_userId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 300.w,
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(8.r),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.black.withValues(alpha: 0.05),
//             blurRadius: 16,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           HomeNetworkImage(
//             imageUrl: widget.imageUrl,
//             width: 300.w,
//             height: 158.h,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
//             fallbackIcon: Icons.fastfood_rounded,
//             fallbackIconSize: 40,
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(19.w, 16.h, 19.w, 16.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.title,
//                   style: AppStyles.headlineSmall.copyWith(
//                     fontWeight: FontWeight.w600,
//                     height: 22 / 18,
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 Row(
//                   children: [
//                     RecipeMetaItem(
//                       icon: Icons.star_rounded,
//                       label: '(${widget.rating})',
//                       iconColor: AppColors.ratingColor,
//                     ),
//                     SizedBox(width: 17.w),
//                     RecipeMetaItem(
//                       icon: Icons.access_time_rounded,
//                       label: widget.time,
//                       iconColor: AppColors.timerColor,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.h),
//                 Row(
//                   children: [
//                     HomeNetworkImage(
//                       imageUrl: widget.authorAvatarUrl,
//                       width: 28.w,
//                       height: 28.w,
//                       borderRadius: BorderRadius.circular(14.r),
//                       fallbackIcon: Icons.person_rounded,
//                       fallbackIconSize: 14,
//                     ),
//                     SizedBox(width: 12.w),
//                     Expanded(
//                       child: Text(
//                         widget.authorName,
//                         style: AppStyles.labelLarge.copyWith(
//                           color: AppColors.textPrimary,
//                           height: 18 / 14,
//                         ),
//                       ),
//                     ),
//                     BlocBuilder<SavedViewModel, SavedState>(
//                       bloc: _savedViewModel,
//                       buildWhen: (_, current) =>
//                       current is BookmarkToggledState ||
//                           current is SavedSuccessState,
//                       builder: (_, __) {
//                         final bool isSaved =
//                         _savedViewModel.isSaved(widget.mealId);
//                         return GestureDetector(
//                           onTap: () => _savedViewModel.toggleBookmark(
//                             userId: _userId,
//                             mealId: widget.mealId,
//                             mealName: widget.title,
//                             mealThumb: widget.imageUrl,
//                           ),
//                           behavior: HitTestBehavior.opaque,
//                           child: Icon(
//                             isSaved
//                                 ? Icons.bookmark_rounded
//                                 : Icons.bookmark_border_rounded,
//                             color: isSaved
//                                 ? AppColors.primaryDark
//                                 : AppColors.primaryColor,
//                             size: 18.sp,
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }