import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/amenity_chip.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/shared/section_card.dart';
import '../../../data/models/amenity_model.dart';

/// Amenities section wrapped in SectionCard with toggle chips.
class EditCourtAmenitiesSection extends StatelessWidget {
  final List<AmenityModel> amenities;
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
    return SectionCard(
      child: amenities.isEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'No amenities available',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
            )
          : Wrap(
              spacing: 8,
              runSpacing: 8,
              children: amenities.map((amenity) {
                final selected = selectedIds.contains(amenity.id);
                return AmenityChip(
                  amenity: amenity,
                  selected: selected,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onToggle(amenity.id);
                  },
                );
              }).toList(),
            ),
    );
  }
}
