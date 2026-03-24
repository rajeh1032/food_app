import 'package:flutter/material.dart';

import 'circle_icon_button.dart';

class HeroImage extends StatelessWidget {
  final String imgUrl;
  const HeroImage({ required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          child: Container(
            height: 260,
            width: double.infinity,
            color: const Color(0xFFE8C9A0), // warm fallback
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFFE8C9A0),
                child: const Icon(Icons.restaurant, size: 80, color: Colors.white54),
              ),
            ),
          ),
        ),

        // Back button
        Positioned(
          top: 48,
          left: 16,
          child: CircleIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.maybePop(context),
          ),
        ),

        // Bookmark button
        Positioned(
          top: 48,
          right: 16,
          child: CircleIconButton(
            icon: Icons.bookmark_rounded,
            iconColor: const Color(0xFFFF8C00),
            onTap: () {},
          ),
        ),

        // Status bar time simulation
        Positioned(
          top: 14,
          left: 20,
          child: Text(
            '09:41',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}