import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({super.key, required this.icon, this.isDanger = false});

  final IconData icon;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    final color = isDanger ? Colors.redAccent : AppColors.primaryColor;
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: color.withValues(alpha: 0.35), width: 1),
      ),
      child: Icon(icon, size: 20, color: color),
    );
  }
}
