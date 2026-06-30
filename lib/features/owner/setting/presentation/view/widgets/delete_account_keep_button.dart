import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

/// Green outlined "Keep My Account" button.
/// Disabled while the delete request is in progress.
class DeleteAccountKeepButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const DeleteAccountKeepButton({
    super.key,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: isEnabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isEnabled
                ? AppColors.primaryColor
                : AppColors.primaryColor.withValues(alpha: 0.3),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          'Keep My Account'.tr,
          style: TextStyle(
            color: isEnabled
                ? AppColors.primaryColor
                : AppColors.primaryColor.withValues(alpha: 0.4),
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
