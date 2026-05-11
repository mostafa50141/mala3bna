import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/edit_court_screen.dart';

class ActionButtons extends StatefulWidget {
  final String? courtId;
  const ActionButtons({super.key, this.courtId});

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  bool _isCourtDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ── Edit Court ──────────────────────────────────────────────
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              final id = widget.courtId ?? 'court_1';

              Get.to(
                () => EditCourtScreen(courtId: id),
                transition: Transition.rightToLeft,
                duration: const Duration(milliseconds: 300),
              );
            },
            icon: const Icon(Icons.edit_outlined, size: 16),
            label: const Text(
              'Edit Court',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shadowColor: AppColors.primaryColor.withValues(alpha: 0.4),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // ── Disable / Enable Court (toggle) ─────────────────────────
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _isCourtDisabled
                ? _buildEnableButton()
                : _buildDisableButton(),
          ),
        ),
      ],
    );
  }

  Widget _buildDisableButton() {
    return OutlinedButton.icon(
      key: const ValueKey('disable'),
      onPressed: () => setState(() => _isCourtDisabled = true),
      icon: Icon(Icons.block_outlined, size: 16, color: Colors.grey.shade400),
      label: Text(
        'Disable Court',
        style: TextStyle(
          color: Colors.grey.shade400,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.grey.shade400,
        side: BorderSide(color: Colors.grey.shade600, width: 1),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildEnableButton() {
    return OutlinedButton.icon(
      key: const ValueKey('enable'),
      onPressed: () => setState(() => _isCourtDisabled = false),
      icon: const Icon(
        Icons.play_circle_outline,
        size: 16,
        color: Colors.redAccent,
      ),
      label: const Text(
        'Enable Court',
        style: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.redAccent,
        side: const BorderSide(color: Colors.redAccent, width: 1),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
