import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../saved/ui/Cubit/saved_states.dart';
import '../../../saved/ui/Cubit/saved_view_model.dart';
import 'home_network_image.dart';
import 'recipe_meta_item.dart';

class FeaturedRecipeCard extends StatelessWidget {
  final String mealId;
  final String imageUrl;
  final String title;
  final String rating;
  final String time;
  final String authorName;
  final String authorAvatarUrl;

  const FeaturedRecipeCard({
    super.key,
    required this.mealId,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.time,
    required this.authorName,
    required this.authorAvatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest';

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
                    BlocBuilder<SavedViewModel, SavedState>(
                      buildWhen: (_, current) =>
                      current is BookmarkToggledState ||
                          current is SavedSuccessState,
                      builder: (context, __) {
                        final isSaved =
                        context.read<SavedViewModel>().isSaved(mealId);
                        return GestureDetector(
                          onTap: () => context.read<SavedViewModel>().toggleBookmark(
                            userId: userId,
                            mealId: mealId,
                            mealName: title,
                            mealThumb: imageUrl,
                          ),
                          behavior: HitTestBehavior.opaque,
                          child: Icon(
                            isSaved
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            color: isSaved
                                ? AppColors.primaryDark
                                : AppColors.primaryColor,
                            size: 18.sp,
                          ),
                        );
                      },
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