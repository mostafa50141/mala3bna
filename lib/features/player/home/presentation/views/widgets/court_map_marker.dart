import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';

class CourtMapMarker extends StatelessWidget {
  final CourtModel court;
  final VoidCallback onTap;

  const CourtMapMarker({
    super.key,
    required this.court,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 4),
          ],
        ),
        child: const Icon(Icons.sports_tennis, color: Colors.white, size: 20),
      ),
    );
  }
}
