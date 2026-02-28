import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/role/user_role.dart';

class CustomeChoiceChip extends StatefulWidget {
  final Function(UserRole) onRoleSelected;

  const CustomeChoiceChip({super.key, required this.onRoleSelected});

  @override
  State<CustomeChoiceChip> createState() => _CustomeChoiceChipState();
}

class _CustomeChoiceChipState extends State<CustomeChoiceChip> {
  UserRole selectedRole = UserRole.player;

  final Map<UserRole, String> options = {
    UserRole.player: "PLAYER",
    UserRole.coach: "COACH",
    UserRole.owner: "OWNER",
  };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: options.entries.map((entry) {
        final role = entry.key;
        final label = entry.value;
        final isSelected = selectedRole == role;

        return ChoiceChip(
          label: Text(label),
          selected: isSelected,
          onSelected: (value) {
            if (value) {
              setState(() {
                selectedRole = role;
              });

              // أهم سطر
              widget.onRoleSelected(role);
            }
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
