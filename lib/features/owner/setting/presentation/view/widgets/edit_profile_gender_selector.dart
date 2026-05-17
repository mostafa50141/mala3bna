import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

/// Male/Female toggle selector with animated pill buttons.
class EditProfileGenderSelector extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const EditProfileGenderSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.07),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _GenderPill(
              label: 'Male',
              icon: Icons.male,
              isSelected: value == 'Male',
              onTap: () => onChanged('Male'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _GenderPill(
              label: 'Female',
              icon: Icons.female,
              isSelected: value == 'Female',
              onTap: () => onChanged('Female'),
            ),
          ),
        ],
      ),
    );
  }
}

class _GenderPill extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderPill({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 36,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.07),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 15,
                  color:
                      isSelected ? AppColors.primaryColor : Colors.white38,
                ),
                const SizedBox(width: 4),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.primaryColor
                        : Colors.white54,
                    fontSize: 13,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
