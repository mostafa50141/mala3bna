import 'package:flutter/material.dart';

/// Animated danger icon displayed at the top of the delete account screen.
class DeleteAccountDangerIcon extends StatelessWidget {
  const DeleteAccountDangerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.redAccent.withValues(alpha: 0.12),
        border: Border.all(
          color: Colors.redAccent.withValues(alpha: 0.25),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withValues(alpha: 0.15),
            blurRadius: 24,
            spreadRadius: 4,
          ),
        ],
      ),
      child: const Icon(
        Icons.delete_forever_rounded,
        color: Colors.redAccent,
        size: 42,
      ),
    );
  }
}
