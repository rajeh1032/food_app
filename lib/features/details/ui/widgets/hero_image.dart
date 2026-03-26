import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import 'circle_icon_button.dart';

class HeroImage extends StatelessWidget {
  final String imgUrl;
  final bool isSaved;
  final VoidCallback? onBookmarkTap;

  const HeroImage({
    super.key,
    required this.imgUrl,
    this.isSaved = false,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.r),
            bottomRight: Radius.circular(24.r),
          ),
          child: Container(
            height: 260.h,
            width: double.infinity,
            color: AppColors.primaryLight,

            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),

        Positioned(
          top: 48.h,
          left: 16.w,
          child: CircleIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.maybePop(context),
          ),
        ),

        Positioned(
          top: 48.h,
          right: 16.w,
          child: CircleIconButton(
            icon:
                isSaved
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_border_rounded,
            iconColor:
                isSaved ? AppColors.primaryDark : AppColors.primaryColor,
            onTap: onBookmarkTap ?? () {},
          ),
        ),
      ],
    );
  }
}
