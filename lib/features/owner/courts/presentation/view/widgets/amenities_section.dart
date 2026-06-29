import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/shared/section_card.dart';

class AmenitiesSectionCourtProfile extends StatelessWidget {
  final CourtEntity vm;

  const AmenitiesSectionCourtProfile({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Amenities'.tr),
          const SizedBox(height: 16),
          _buildAmenitiesWrap(),
        ],
      ),
    );
  }

  Widget _buildAmenitiesWrap() {
    if (vm.amenities.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'No amenities listed.'.tr,
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

  Widget _amenityChip(AmenityEntity item) {
    IconData icon;
    switch (item.id) {
      case 'lights':
        icon = Icons.lightbulb_outline;
        break;
      case 'showers':
        icon = Icons.shower_outlined;
        break;
      case 'cafe':
        icon = Icons.local_cafe_outlined;
        break;
      case 'equipment':
        icon = Icons.sports_soccer_outlined;
        break;
      default:
        icon = Icons.check_circle_outline;
    }

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
          Icon(icon, color: AppColors.primaryColor, size: 16),
          const SizedBox(width: 6),
          Text(
            item.title.tr,
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
