import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/shared/section_card.dart';

/// Location preview card with coordinates display and change button.
class EditCourtLocationSection extends StatelessWidget {
  final double? lat;
  final double? lng;
  final VoidCallback onChangeLocation;

  const EditCourtLocationSection({
    super.key,
    required this.lat,
    required this.lng,
    required this.onChangeLocation,
  });

  bool get _hasLocation => lat != null && lng != null;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Map placeholder
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withValues(alpha: 0.05),
              border:
                  Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _hasLocation ? Icons.place : Icons.map_outlined,
                    color: _hasLocation
                        ? AppColors.primaryColor
                        : Colors.white.withValues(alpha: 0.3),
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _hasLocation ? 'Location Set' : 'No location set',
                    style: TextStyle(
                      color: _hasLocation
                          ? Colors.white70
                          : Colors.white.withValues(alpha: 0.3),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Coordinates row
          Row(
            children: [
              Icon(Icons.my_location_rounded,
                  size: 16, color: AppColors.primaryColor),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  _hasLocation
                      ? '${lat!.toStringAsFixed(4)}, ${lng!.toStringAsFixed(4)}'
                      : 'Not specified',
                  style:
                      const TextStyle(color: Colors.white60, fontSize: 13),
                ),
              ),
              TextButton.icon(
                onPressed: onChangeLocation,
                icon: Icon(Icons.edit_location_alt_outlined,
                    size: 16, color: AppColors.primaryColor),
                label: Text(
                  'Change',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color:
                          AppColors.primaryColor.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
