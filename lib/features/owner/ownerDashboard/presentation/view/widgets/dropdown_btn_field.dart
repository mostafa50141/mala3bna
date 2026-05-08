import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

class DropdownBtnField extends StatelessWidget {
  DropdownBtnField({super.key});
  final sportTypes = ['Football', 'Basketball', 'Tennis', 'Padel'];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.colorBtnAndCard,
        hintText: 'Select a Sport Type',
        hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
        prefixIcon:
            Icon(Icons.category_outlined, color: AppColors.primaryColor, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: Colors.white.withOpacity(0.07), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      ),
      dropdownColor: const Color(0xFF1E2530),
      style: const TextStyle(color: Colors.white, fontSize: 14),
      icon: Icon(Icons.keyboard_arrow_down_rounded,
          color: Colors.white54, size: 22),
      items: sportTypes
          .map(
            (sport) => DropdownMenuItem(
              value: sport,
              child: Text(
                sport,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        debugPrint('Selected sport type: $value');
      },
      validator: (value) =>
          value == null ? 'Please select a sport type' : null,
    );
  }
}
