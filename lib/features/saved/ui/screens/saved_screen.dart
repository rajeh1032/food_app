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

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<SavedViewModel>();
    _userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest';
    _viewModel.loadSavedMeals(_userId);
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
                _buildHeader(),
                SizedBox(height: 20.h),
                Expanded(child: _buildBody()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      'Recipe Saved',
      style: AppStyles.headlineMedium.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
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
            child: Text(
              state.message,
              style: AppStyles.bodyMedium.copyWith(color: AppColors.errorColor),
            ),
          );
        }

        if (state is SavedSuccessState) {
          if (state.meals.isEmpty) return const SavedEmptyState();

          return ListView.separated(
            itemCount: state.meals.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            padding: EdgeInsets.only(bottom: 16.h),
            itemBuilder: (context, index) {
              final meal = state.meals[index];
              return SavedMealCard(
                meal: meal,
                onRemove: () {
                  _viewModel.toggleBookmark(
                    userId: _userId,
                    mealId: meal.mealId,
                    mealName: meal.mealName,
                    mealThumb: meal.mealThumb,
                  );
                },
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}