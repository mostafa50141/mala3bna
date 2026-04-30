import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/presentation/model/court_profile_model.dart';

class AmenitiesSectionCourtProfile extends StatelessWidget {
  final CourtProfileModel vm;

  const AmenitiesSectionCourtProfile({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Amenities',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          // 2-column grid
          _buildGrid(),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    final items = vm.amenities;
    // Build rows of 2
    final rows = <Widget>[];
    for (int i = 0; i < items.length; i += 2) {
      rows.add(
        Row(
          children: [
            Expanded(child: _amenityTile(items[i])),
            if (i + 1 < items.length) ...[
              const SizedBox(width: 12),
              Expanded(child: _amenityTile(items[i + 1])),
            ] else
              const Expanded(child: SizedBox()),
          ],
        ),
      );
      if (i + 2 < items.length) rows.add(const SizedBox(height: 12));
    }
    return Column(children: rows);
  }

  Widget _amenityTile(CourtAmenity item) {
    return Row(
      children: [
        Icon(
          item.icon,
          color: AppColors.primaryColor,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          item.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
