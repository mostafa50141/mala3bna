import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

/// Styled password text field with visibility toggle.
class ChangePasswordField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool isVisible;
  final ValueChanged<String> onChanged;
  final VoidCallback onToggleVisibility;
  final bool enabled;
  final bool showMatchIcon;
  final bool isMatch;

  const ChangePasswordField({
    super.key,
    required this.hint,
    required this.icon,
    required this.isVisible,
    required this.onChanged,
    required this.onToggleVisibility,
    this.enabled = true,
    this.showMatchIcon = false,
    this.isMatch = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;

    return TextFormField(
      obscureText: !isVisible,
      enabled: enabled,
      onChanged: onChanged,
      style: TextStyle(color: textColor, fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: isDark ? Colors.white.withValues(alpha: 0.25) : Colors.black.withValues(alpha: 0.3),
          fontSize: 14,
        ),
        prefixIcon: Icon(icon, color: isDark ? Colors.white38 : Colors.black38, size: 20),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showMatchIcon)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  isMatch ? Icons.check_circle : Icons.cancel,
                  size: 18,
                  color: isMatch
                      ? AppColors.primaryColor
                      : Colors.redAccent.withValues(alpha: 0.6),
                ),
              ),
            IconButton(
              icon: Icon(
                isVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: isDark ? Colors.white38 : Colors.black38,
                size: 20,
              ),
              onPressed: onToggleVisibility,
            ),
          ],
        ),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white.withValues(alpha: 0.07) : Colors.black.withValues(alpha: 0.07),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.black.withValues(alpha: 0.04),
          ),
        ),
      ),
    );
  }
}
