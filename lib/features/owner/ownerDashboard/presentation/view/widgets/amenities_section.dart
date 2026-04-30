import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/ownerDashboard/data/amenity_of_add_court.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/amenities_widget.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/form_widgets.dart';

class AmenitiesSection extends StatelessWidget {
  const AmenitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AddCourtSectionHeader(
          icon: Icons.check_circle_outline,
          title: 'Amenities',
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
            debugPrint('Selected: $selectedIds');
          },
        ),

        const SizedBox(height: 28),

        // Save button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Save Court',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Cancel button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            onPressed: () => Navigator.maybePop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white70,
              side: BorderSide(color: Colors.white.withOpacity(0.15), width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
