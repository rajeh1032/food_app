
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IngredientsList extends StatelessWidget {
  final List<String> ingredients;
  final List<String> measures;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const IngredientsList({
    super.key,
    required this.ingredients,
    required this.measures,
    this.shrinkWrap = true,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount =
        ingredients.length < measures.length
            ? ingredients.length
            : measures.length;

    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final measure = measures[index].trim();
        final ingredient = ingredients[index].trim();
        final item =
            measure.isEmpty ? ingredient : '$measure $ingredient';

        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: Container(
                  width: 7.w,
                  height: 7.w,
                  decoration: const BoxDecoration(
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
    );
  }
}
