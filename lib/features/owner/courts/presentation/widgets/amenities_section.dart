import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/owner/courts/presentation/view_model/court_view_model.dart';

class AmenitiesSectionCourtProfile extends StatelessWidget {
  final CourtViewModel vm;

  const AmenitiesSectionCourtProfile({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Amenities", style: Style.textStyle16Bold),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: vm.amenities.map((item) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item["icon"], color: AppColors.primaryColor),
                  const SizedBox(width: 6),
                  Text(item["title"], style: Style.textStyle14Bold),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
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
