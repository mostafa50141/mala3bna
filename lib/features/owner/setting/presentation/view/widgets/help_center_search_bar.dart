import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

class HelpCenterSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const HelpCenterSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          hintText: 'Search for topics or keywords...',
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.3),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Colors.white.withValues(alpha: 0.4),
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
