import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

class DashedAddPhoto extends StatelessWidget {
  const DashedAddPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.colorBtnAndCard,
        border: Border.all(color: Colors.white12, width: 1),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.add_a_photo_outlined, color: Colors.white54, size: 28),
            SizedBox(height: 8),
            Text('Add Photo', style: TextStyle(color: Colors.white54)),
          ],
        ),
      ),
    );
  }
}
