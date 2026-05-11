import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import '../../../data/models/amenity_model.dart';

class AmenityChip extends StatelessWidget {
  final AmenityModel amenity;
  final bool selected;
  final VoidCallback onTap;

  const AmenityChip({
    super.key,
    required this.amenity,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? AppColors.primaryColor : AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? AppColors.primaryColor : Colors.white12,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 18,
              color: Colors.white70,
            ),
            const SizedBox(width: 8),
            Text(amenity.title, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
