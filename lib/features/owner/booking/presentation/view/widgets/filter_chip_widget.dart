import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;

  const FilterChipWidget({
    super.key,
    required this.label,
    this.isActive = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primaryColor.withOpacity(.15)
            : const Color(0xFF1C1F26),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isActive ? AppColors.primaryColor : Colors.transparent,
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: isActive ? AppColors.primaryColor : Colors.white70,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Style.textStyle14Bold.copyWith(
              color: isActive ? AppColors.primaryColor : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
