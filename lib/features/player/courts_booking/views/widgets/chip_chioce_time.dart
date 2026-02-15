import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/time_slot.dart';

class CustomeChoiceChipTime extends StatefulWidget {
  const CustomeChoiceChipTime({super.key});

  @override
  State<CustomeChoiceChipTime> createState() => _CustomeChoiceChipTimeState();
}

class _CustomeChoiceChipTimeState extends State<CustomeChoiceChipTime> {
  late List<String> timeSlots;
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    timeSlots = TimeSlot.generateTimeSlots(
      start: TimeOfDay(hour: 16, minute: 0), // 4:00 PM
      end: TimeOfDay(hour: 4, minute: 0), // 12:00 AM
      intervalMinutes: 60,
    );
    if (timeSlots.isNotEmpty) {
      selectedOption = timeSlots[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: timeSlots.map((option) {
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
