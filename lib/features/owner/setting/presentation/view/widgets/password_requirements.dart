import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

/// Animated password requirements checklist.
class PasswordRequirements extends StatelessWidget {
  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasSpecialChar;
  final bool isVisible;

  const PasswordRequirements({
    super.key,
    required this.hasMinLength,
    required this.hasUppercase,
    required this.hasSpecialChar,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: isVisible
          ? Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.colorBtnAndCard.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.verified_user_outlined,
                          size: 16, color: AppColors.primaryColor),
                      const SizedBox(width: 6),
                      Text(
                        'PASSWORD REQUIREMENTS',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _RequirementRow(
                    label: 'Minimum 8 characters',
                    isMet: hasMinLength,
                  ),
                  const SizedBox(height: 8),
                  _RequirementRow(
                    label: 'At least one uppercase letter',
                    isMet: hasUppercase,
                  ),
                  const SizedBox(height: 8),
                  _RequirementRow(
                    label: 'At least one special character',
                    isMet: hasSpecialChar,
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class _RequirementRow extends StatelessWidget {
  final String label;
  final bool isMet;

  const _RequirementRow({required this.label, required this.isMet});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Icon(
            isMet ? Icons.check_circle : Icons.circle_outlined,
            key: ValueKey(isMet),
            size: 16,
            color: isMet
                ? AppColors.primaryColor
                : Colors.white.withValues(alpha: 0.25),
          ),
        ),
        const SizedBox(width: 8),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 250),
          style: TextStyle(
            color: isMet
                ? Colors.white.withValues(alpha: 0.7)
                : Colors.white.withValues(alpha: 0.35),
            fontSize: 13,
            fontWeight: isMet ? FontWeight.w500 : FontWeight.w400,
          ),
          child: Text(label),
        ),
      ],
    );
  }
}
