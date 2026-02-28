import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class DropdownBtnField extends StatelessWidget {
  DropdownBtnField({super.key});
  final sportTypes = ['Football', 'Basketball', 'Tennis', 'padel'];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        hintText: 'Select a Sport Type',
        hintStyle: Style.textStyle16,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
      ),

      dropdownColor: AppColors.primaryColor,
      style: Style.textStyle16Bold,
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
      validator: (value) => value == null ? 'Please select a sport type' : null,
    );
  }
}
