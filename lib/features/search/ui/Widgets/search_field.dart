
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/search_cubit.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (value) {
        context.read<SearchCubit>().searchMeals(value);
      },
      onChanged: (value) {
        if (value.length > 2) {
          context.read<SearchCubit>().searchMeals(value);
        }
      },
      decoration: InputDecoration(
        hintText: "Type ingredients...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: AppColors.scaffoldBgColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}