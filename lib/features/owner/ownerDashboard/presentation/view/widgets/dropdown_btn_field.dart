import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

class DropdownBtnField extends StatelessWidget {
  DropdownBtnField({super.key});
  final sportTypes = ['Football', 'Basketball', 'Tennis', 'Padel'];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).cardColor,
        hintText: 'Select a Sport Type'.tr,
        hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.38) ?? Colors.white38, fontSize: 14),
        prefixIcon:
            Icon(Icons.category_outlined, color: AppColors.primaryColor, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.07) ?? Colors.white.withOpacity(0.07), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      ),
      dropdownColor: Theme.of(context).cardColor,
      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white, fontSize: 14),
      icon: Icon(Icons.keyboard_arrow_down_rounded,
          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.54) ?? Colors.white54, size: 22),
      items: sportTypes
          .map(
            (sport) => DropdownMenuItem(
              value: sport,
              child: Text(
                sport.tr,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        debugPrint('Selected sport type: $value');
      },
      validator: (value) =>
          value == null ? 'Please select a sport type'.tr : null,
    );
  }
}
