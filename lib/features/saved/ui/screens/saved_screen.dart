import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../Cubit/saved_states.dart';
import '../Cubit/saved_view_model.dart';
import '../Widgets/saved_empty_state.dart';
import '../Widgets/saved_meal_card.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  late final SavedViewModel _viewModel;
  late final String _userId;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<SavedViewModel>();
    _userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest';
    _viewModel.loadSavedMeals(_userId);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBgColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                Text(
                  'Recipe Saved',
                  style: AppStyles.headlineMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 16.h),
                // Search bar
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) => setState(() => _searchQuery = val.toLowerCase()),
                    decoration: InputDecoration(
                      hintText: 'Search saved recipes...',
                      hintStyle: AppStyles.bodyMedium.copyWith(color: AppColors.textHint),
                      prefixIcon: Icon(Icons.search, color: AppColors.textHint, size: 20.sp),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(child: _buildBody()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<SavedViewModel, SavedState>(
      builder: (context, state) {
        if (state is SavedLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SavedErrorState) {
          return Center(
            child: Text(state.message,
                style: AppStyles.bodyMedium.copyWith(color: AppColors.errorColor)),
          );
        }
        if (state is SavedSuccessState) {
          final meals = _searchQuery.isEmpty
              ? state.meals
              : state.meals
              .where((m) => m.mealName.toLowerCase().contains(_searchQuery))
              .toList();

          if (meals.isEmpty) return const SavedEmptyState();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.78,
            ),
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return SavedMealCard(
                meal: meal,
                onRemove: () => _viewModel.toggleBookmark(
                  userId: _userId,
                  mealId: meal.mealId,
                  mealName: meal.mealName,
                  mealThumb: meal.mealThumb,
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}