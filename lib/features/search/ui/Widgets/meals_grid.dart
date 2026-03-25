import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/app_styles.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/search_cubit.dart';
import '../models/meal_model.dart';

class MealsGrid extends StatelessWidget {
  final List<MealModel> meals;

  const MealsGrid({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: meals.length,
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        mainAxisExtent: 220.h,
      ),
      itemBuilder: (context, index) {
        final meal = meals[index];

        return GestureDetector(
          onTap: () {
            final cubit = context.read<SearchCubit>();
            cubit.addToLastViewed(meal);
            cubit.addToSearchHistory(meal);
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.scaffoldBgColor,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
                  child: Image.network(
                    meal.strMealThumb ?? "",
                    height: 120.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        meal.strMeal ?? "",
                        style: AppStyles.titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5.h),

                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "(${meal.rate})",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}