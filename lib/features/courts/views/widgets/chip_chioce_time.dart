import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

class CustomeChoiceChipTime extends StatefulWidget {
  const CustomeChoiceChipTime({super.key});

  @override
  State<CustomeChoiceChipTime> createState() => _CustomeChoiceChipTimeState();
}

class _CustomeChoiceChipTimeState extends State<CustomeChoiceChipTime> {
  List<String> options = [
    "4:0 PM",
    "5:0 PM",
    "6:0 PM",
    "7:0 PM",
    "8:0 PM",
    "9:0 PM",
    "10:0 PM",
    "11:0 PM",
    "12:0 AM",
  ];
  String selectedOption = "4:00 PM";

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
