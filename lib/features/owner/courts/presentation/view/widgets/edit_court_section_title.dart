import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

/// Reusable section title row with icon + label.
class EditCourtSectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const EditCourtSectionTitle({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
