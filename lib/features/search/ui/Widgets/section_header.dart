import 'package:flutter/material.dart';
import '../../../../core/theme/app_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onTap;

  const SectionHeader({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppStyles.headlineMedium),
        TextButton(onPressed: onTap, child: Text(buttonText)),
      ],
    );
  }
}
