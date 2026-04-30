import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

class StarsWidget extends StatelessWidget {
  final double rating;

  const StarsWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: AppColors.primaryColor, size: 16);
        } else if (index < rating && rating % 1 != 0) {
          return Icon(Icons.star_half, color: AppColors.primaryColor, size: 16);
        } else {
          return Icon(
            Icons.star_border,
            color: AppColors.primaryColor,
            size: 16,
          );
        }
      }),
    );
  }
}
