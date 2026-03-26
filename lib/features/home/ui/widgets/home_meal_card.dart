import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../details/ui/screens/details_screen.dart';
import 'home_network_image.dart';

class HomeMealCard extends StatelessWidget {
  final String imageUrl;
  final String mealId;
  final String title;
  final String timeLabel;
  final bool isSaved;
  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;

  const HomeMealCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.timeLabel,
    this.isSaved = false,
    this.onTap,
    this.onFavoritePressed,
    required this.mealId,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final cardWidth =
    math.max(205.w, math.min(280.w, screenWidth * 0.7)).toDouble();
    final contentPadding = cardWidth < 240.w ? 11.w : 12.w;
    final actionButtonSize =
    math.max(28.w, math.min(30.w, cardWidth * 0.105)).toDouble();
    final titleStyle = AppStyles.headlineSmall.copyWith(
      fontSize: cardWidth < 240.w ? 15.sp : 16.sp,
      height: 1.25,
    );
    final timeStyle = AppStyles.bodySmall.copyWith(
      color: AppColors.textHint,
      fontSize: 11.5.sp,
      height: 1.2,
    );

    return SizedBox(
      width: cardWidth,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardHeight =
          constraints.maxHeight.isFinite ? constraints.maxHeight : 260.h;
          final imageHeight =
          math.min(cardHeight * 0.52, cardWidth * 0.55).toDouble();
          final footerGap = 7.h;

          return GestureDetector(
            onTap: () {
              onTap?.call();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeDetailPage(mealId: mealId),
                ),
              );
            },
              child:Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.gray100),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.05),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeNetworkImage(
                  imageUrl: imageUrl,
                  width: double.infinity,
                  height: imageHeight,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(16.r)),
                  fallbackIcon: Icons.fastfood_rounded,
                  fallbackIconSize: 40,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(contentPadding),
                    child: LayoutBuilder(
                      builder: (context, contentConstraints) {
                        final titleAreaHeight = math.max(
                          0.0,
                          math.min(
                            46.h,
                            contentConstraints.maxHeight -
                                actionButtonSize -
                                footerGap,
                          ),
                        );

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: titleAreaHeight,
                              width: double.infinity,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Text(
                                  title,
                                  style: titleStyle,
                                ),
                              ),
                            ),
                            SizedBox(height: footerGap),
                            SizedBox(
                              height: actionButtonSize,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    size: 15.sp,
                                    color: AppColors.textHint,
                                  ),
                                  SizedBox(width: 6.w),
                                  Expanded(
                                    child: Text(
                                      timeLabel,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: timeStyle,
                                    ),
                                  ),
                                  Container(
                                    width: actionButtonSize,
                                    height: actionButtonSize,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor.withValues(
                                        alpha: isSaved ? 0.2 : 0.12,
                                      ),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: onFavoritePressed,
                                      icon: AnimatedSwitcher(
                                        duration:
                                        const Duration(milliseconds: 180),
                                        child: Icon(
                                          isSaved
                                              ? Icons.favorite_rounded
                                              : Icons.favorite_border_rounded,
                                          key: ValueKey(isSaved),
                                          size: 17.sp,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
