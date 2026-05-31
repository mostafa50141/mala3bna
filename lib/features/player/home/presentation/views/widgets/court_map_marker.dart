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

  IconData _getCourtIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'football':
        return Icons.sports_soccer;
      case 'swimming':
        return Icons.pool;
      case 'tennis':
        return Icons.sports_tennis;
      case 'padel':
        return Icons.sports_tennis;
      default:
        return Icons.sports;
    }
  }

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
        child: Icon(_getCourtIcon(court.sport), color: Colors.white, size: 20),
      ),
    );
  }
}
