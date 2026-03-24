import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class SearchHistory extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String image;
  final String? rate;
  final bool isVertical;

  const SearchHistory({
    super.key,
    required this.title,
    this.subtitle,
    required this.image,
    this.rate,
    this.isVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isVertical
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: image.startsWith('http')
                        ? Image.network(
                            image,
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            image,
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(height: 10),
                  Text(title,
                      style: AppStyles.titleMedium
                          .copyWith(color: AppColors.black)),
                  if (subtitle != null) ...[
                    SizedBox(height: 5),
                    Text(subtitle!,
                        style: AppStyles.titleMedium
                            .copyWith(color: AppColors.gray500)),
                  ],
                  if (rate != null) ...[
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        SizedBox(width: 4),
                        Text(rate!),
                      ],
                    ),
                  ],
                ],
              )
            : Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: image.startsWith('http')
                        ? Image.network(
                            image,
                            width: 67,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            image,
                            width: 67,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: AppStyles.titleMedium
                                .copyWith(color: AppColors.black,fontSize: 15)),
                        if (subtitle != null)
                          Text(subtitle!,
                              style: AppStyles.titleMedium
                                  .copyWith(color: AppColors.gray500)),
                        if (rate != null)
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              SizedBox(width: 4),
                              Text(rate!),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
