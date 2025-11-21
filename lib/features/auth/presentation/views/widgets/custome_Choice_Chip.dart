import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

class CustomeChoiceChip extends StatefulWidget {
  const CustomeChoiceChip({super.key});

  @override
  State<CustomeChoiceChip> createState() => _CustomeChoiceChipState();
}

class _CustomeChoiceChipState extends State<CustomeChoiceChip> {
  //  int _selectedIndex = 0;
  List<String> options = ["PLAYER", "COACH", "OWNER"];
  String selectedOption = "PLAYER";

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: options.map((option) {
        final isSelected = selectedOption == option;
        return ChoiceChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (isSelected) {
            setState(() {
              if (isSelected) {
                selectedOption = option;
              }
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          selectedColor: AppColors.primaryColor,
          backgroundColor: AppColors.fieldBackground.withOpacity(0.3),

          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        );
      }).toList(),
    );
  }
}
