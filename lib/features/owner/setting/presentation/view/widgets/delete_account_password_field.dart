import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Password confirmation field for the delete account flow.
/// Shows a "CONFIRM WITH PASSWORD" label, red focused border, and visibility toggle.
class DeleteAccountPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool isVisible;
  final bool isEnabled;
  final ValueChanged<String> onChanged;
  final VoidCallback onToggleVisibility;

  const DeleteAccountPasswordField({
    super.key,
    required this.controller,
    required this.isVisible,
    required this.isEnabled,
    required this.onChanged,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CONFIRM WITH PASSWORD'.tr,
          style: TextStyle(
            color: isDark
                ? Colors.white.withValues(alpha: 0.45)
                : Colors.black.withValues(alpha: 0.45),
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.3,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          obscureText: !isVisible,
          enabled: isEnabled,
          onChanged: onChanged,
          style: TextStyle(color: textColor, fontSize: 15),
          decoration: InputDecoration(
            hintText: 'Enter current password'.tr,
            hintStyle: TextStyle(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.22)
                  : Colors.black.withValues(alpha: 0.3),
              fontSize: 14,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: isDark ? Colors.white38 : Colors.black38,
                size: 20,
              ),
              onPressed: onToggleVisibility,
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.07)
                    : Colors.black.withValues(alpha: 0.07),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.redAccent.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.04)
                    : Colors.black.withValues(alpha: 0.04),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
