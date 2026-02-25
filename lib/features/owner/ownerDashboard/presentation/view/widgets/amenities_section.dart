import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';
import 'package:mala3bna/core/widgets/section_title.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/data/amenity_of_add_court.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/amenities_widget.dart';

class AmenitiesSection extends StatelessWidget {
  const AmenitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "Amenities"),

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
            debugPrint('Selected: $selectedIds');
          },
        ),
        const SizedBox(height: 32),
        CustomBtn(
          text: 'Save',
          weightText: FontWeight.bold,
          sizeText: 16,
          height: 50,
          width: double.infinity,
          radius: 20,
        ),

        const SizedBox(height: 8),
        CustomBtn(
          text: 'Cancel',
          weightText: FontWeight.bold,
          sizeText: 16,
          height: 50,
          width: double.infinity,
          radius: 20,
          color: AppColors.colorBtnAndCard,
          colorText: Colors.white,
        ),
      ],
    );
  }
}
