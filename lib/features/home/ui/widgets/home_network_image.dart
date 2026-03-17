import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class HomeNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final BoxFit fit;
  final IconData fallbackIcon;
  final double fallbackIconSize;

  const HomeNetworkImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.borderRadius,
    this.fit = BoxFit.cover,
    this.fallbackIcon = Icons.restaurant_menu_rounded,
    this.fallbackIconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: imageUrl,
        fit: fit,
        placeholder: (context, url) {
          return _LoadingImage(
            width: width,
            height: height,
          );
        },
        errorWidget: (context, url, error) {
          return _FallbackImage(
            width: width,
            height: height,
            icon: fallbackIcon,
            iconSize: fallbackIconSize,
          );
        },
      ),
    );
  }
}

class _LoadingImage extends StatelessWidget {
  final double width;
  final double height;

  const _LoadingImage({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF0D9), Color(0xFFF3F4F6)],
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 28.w,
          height: 28.w,
          child: const CircularProgressIndicator(
            strokeWidth: 2.5,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

class _FallbackImage extends StatelessWidget {
  final double width;
  final double height;
  final IconData icon;
  final double iconSize;

  const _FallbackImage({
    required this.width,
    required this.height,
    required this.icon,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF0D9), Color(0xFFF3F4F6)],
        ),
      ),
      child: Icon(icon, color: AppColors.primaryColor, size: iconSize.sp),
    );
  }
}
