import 'package:flutter/material.dart';
import 'package:mala3bna/core/utils/style.dart';

class AmenitiesItem extends StatelessWidget {
  const AmenitiesItem({
    super.key,
    required this.icon,
    required this.label,
    this.color = const Color(0xff217A63),
  });
  final IconData icon;
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 18, // outer radius (border)
          backgroundColor: const Color(0xff217A63),
          child: CircleAvatar(
            radius: 16, // inner circle
            backgroundColor: const Color(0xFF2B3A41),
            child: Icon(
              icon,
              color: color, // Icon color
              size: 28,
            ),
          ),
        ),

        const SizedBox(height: 8),
        Text(label, style: Style.textStyle16, textAlign: TextAlign.center),
      ],
    );
  }
}
