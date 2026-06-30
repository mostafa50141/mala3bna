import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

/// Card container that groups related form fields with a subtle border.
class EditProfileFieldsCard extends StatelessWidget {
  final Widget child;
  final double padding;

  const EditProfileFieldsCard({
    super.key,
    required this.child,
    this.padding = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}
