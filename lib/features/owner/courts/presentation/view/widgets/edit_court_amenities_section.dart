import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';

// All possible amenities the backend supports (via boolean flags)
const _kAllAmenities = [
  _AmenityOption(id: 'lights',    label: 'Lights',    icon: Icons.lightbulb_outline),
  _AmenityOption(id: 'showers',   label: 'Showers',   icon: Icons.shower_outlined),
  _AmenityOption(id: 'cafe',      label: 'Cafe',      icon: Icons.local_cafe_outlined),
  _AmenityOption(id: 'equipment', label: 'Equipment', icon: Icons.sports_soccer_outlined),
];

class _AmenityOption {
  final String id;
  final String label;
  final IconData icon;
  const _AmenityOption({required this.id, required this.label, required this.icon});
}

/// Amenities section with all toggleable options — independent of backend list.
class EditCourtAmenitiesSection extends StatelessWidget {
  // kept for API compatibility but not used (we use _kAllAmenities instead)
  final List<AmenityEntity> amenities;
  final Set<String> selectedIds;
  final ValueChanged<String> onToggle;

  const EditCourtAmenitiesSection({
    super.key,
    required this.amenities,
    required this.selectedIds,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _kAllAmenities.map((opt) {
        final selected = selectedIds.contains(opt.id);
        return GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            onToggle(opt.id);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.primaryColor.withValues(alpha: 0.18)
                  : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected
                    ? AppColors.primaryColor
                    : Colors.white.withValues(alpha: 0.12),
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: Icon(
                    selected ? Icons.check_circle : opt.icon,
                    key: ValueKey(selected),
                    size: 18,
                    color: selected ? AppColors.primaryColor : Colors.white38,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  opt.label.tr,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.white60,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
