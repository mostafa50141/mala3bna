import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({super.key, required this.icon, this.isDanger = false});

  final IconData icon;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: isDanger
            ? Colors.red.withOpacity(0.15)
            : const Color.fromARGB(148, 31, 59, 47),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          right: BorderSide(
            color: isDanger ? Colors.redAccent : AppColors.primaryColor,
            width: 1,
          ),
        ),
      ),
      child: Icon(
        icon,
        size: 22,
        color: isDanger ? Colors.redAccent : AppColors.primaryColor,
      ),
    );
  }
}
