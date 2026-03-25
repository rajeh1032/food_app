// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/di/di.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../saved/ui/Cubit/saved_states.dart';
// import '../../../saved/ui/Cubit/saved_view_model.dart';
//
// /// Drop anywhere — Home card, Details screen, etc.
// /// Gets userId automatically from FirebaseAuth.
// class BookmarkButton extends StatefulWidget {
//   final String mealId;
//   final String mealName;
//   final String mealThumb;
//   final double? size;
//   final Color? activeColor;
//   final Color? inactiveColor;
//
//   const BookmarkButton({
//     super.key,
//     required this.mealId,
//     required this.mealName,
//     required this.mealThumb,
//     this.size,
//     this.activeColor,
//     this.inactiveColor,
//   });
//
//   @override
//   State<BookmarkButton> createState() => _BookmarkButtonState();
// }
//
// class _BookmarkButtonState extends State<BookmarkButton> {
//   late final SavedViewModel _viewModel;
//   late final String _userId;
//
//   @override
//   void initState() {
//     super.initState();
//     _viewModel = getIt<SavedViewModel>();
//     _userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest';
//     _viewModel.preloadSavedIds(_userId);
//   }
//
//   void _toggle() {
//     _viewModel.toggleBookmark(
//       userId: _userId,
//       mealId: widget.mealId,
//       mealName: widget.mealName,
//       mealThumb: widget.mealThumb,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SavedViewModel, SavedState>(
//       bloc: _viewModel,
//       buildWhen: (_, current) =>
//       current is BookmarkToggledState || current is SavedSuccessState,
//       builder: (_, __) {
//         final saved = _viewModel.isSaved(widget.mealId);
//         return GestureDetector(
//           onTap: _toggle,
//           behavior: HitTestBehavior.opaque,
//           child: Padding(
//             padding: const EdgeInsets.all(4),
//             child: AnimatedSwitcher(
//               duration: const Duration(milliseconds: 200),
//               child: Icon(
//                 saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
//                 key: ValueKey(saved),
//                 color: saved
//                     ? (widget.activeColor ?? AppColors.primaryColor)
//                     : (widget.inactiveColor ?? AppColors.primaryColor),
//                 size: (widget.size ?? 20).sp,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }