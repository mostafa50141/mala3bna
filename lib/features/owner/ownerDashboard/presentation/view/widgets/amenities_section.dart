import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/amenities_widget.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/form_widgets.dart';

class AmenitiesSection extends StatelessWidget {
  final ValueChanged<List<String>> onAmenitiesChanged;

  const AmenitiesSection({super.key, required this.onAmenitiesChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddCourtSectionHeader(
          icon: Icons.check_circle_outline,
          title: 'Amenities'.tr,
        ),
        const SizedBox(height: 12),

        AmenitiesWidget(
          amenities: [
            Amenity(id: 'lights', label: 'Lights'),
            Amenity(id: 'showers', label: 'Showers'),
            Amenity(id: 'cafe', label: 'Cafe'),
            Amenity(id: 'equipment', label: 'Equipment'),
            Amenity(id: 'parking', label: 'Parking'),
            Amenity(id: 'wifi', label: 'Wi-Fi'),
          ],
          onChanged: (selected) {
            final selectedIds = selected
                .where((a) => a.isSelected)
                .map((a) => a.id)
                .toList();
            onAmenitiesChanged(selectedIds);
          },
        ),
      ],
    );
  }
}
