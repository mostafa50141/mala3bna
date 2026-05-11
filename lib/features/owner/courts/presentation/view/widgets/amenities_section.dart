import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/presentation/view_model/court_profile_model.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/shared/section_card.dart';

class AmenitiesSectionCourtProfile extends StatelessWidget {
  final CourtProfileModel vm;

  const AmenitiesSectionCourtProfile({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Amenities'),
          const SizedBox(height: 16),
          _buildAmenitiesWrap(),
        ],
      ),
    );
  }

  Widget _buildAmenitiesWrap() {
    if (vm.amenities.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'No amenities listed.',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: vm.amenities.map(_amenityChip).toList(),
    );
  }

  Widget _amenityChip(CourtAmenity item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.30),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(item.icon, color: AppColors.primaryColor, size: 16),
          const SizedBox(width: 6),
          Text(
            item.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
