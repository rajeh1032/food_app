
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            EdgeInsets.only(bottom: 10.h),

            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Padding(
                  padding:
                  EdgeInsets.only(top: 6.h),

                  child: Container(
                    width: 7.w,
                    height: 7.w,
                    decoration:
                    const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),

                SizedBox(width: 10.w),

                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 13.5.sp,
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