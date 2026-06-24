import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';

class AmenityChip extends StatelessWidget {
  final AmenityEntity amenity;
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
    // GestureDetector wraps the entire chip so the whole area is tappable
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryColor.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? AppColors.primaryColor
                : Colors.white.withValues(alpha: 0.1),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                selected ? Icons.check_circle : Icons.circle_outlined,
                key: ValueKey(selected),
                size: 18,
                color: selected ? AppColors.primaryColor : Colors.white38,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              amenity.title,
              style: TextStyle(
                color: selected ? Colors.white : Colors.white70,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
