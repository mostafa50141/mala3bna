import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

/// Animated password strength indicator bar with label.
class PasswordStrengthBar extends StatelessWidget {
  final double progress;
  final String label;

  const PasswordStrengthBar({
    super.key,
    required this.progress,
    required this.label,
  });

  Color get _color {
    if (progress <= 0.25) return Colors.redAccent;
    if (progress <= 0.5) return Colors.orangeAccent;
    if (progress <= 0.75) return Colors.amber;
    return AppColors.primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            height: 4,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              builder: (_, value, __) {
                final isDark = Theme.of(context).brightness == Brightness.dark;
                return LinearProgressIndicator(
                  value: value,
                  backgroundColor: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.08),
                  valueColor: AlwaysStoppedAnimation(_color),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 6),

        // Label
        Row(
          children: [
            Text(
              'Password strength: '.tr,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withValues(alpha: 0.4)
                    : Colors.black.withValues(alpha: 0.4),
                fontSize: 12,
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Text(
                label.tr,
                key: ValueKey(label),
                style: TextStyle(
                  color: _color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
