import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

/// Hero banner at the top of the Privacy Policy screen.
/// Shows "Your Data, Protected." headline and a brief intro.
class PrivacyHeaderBanner extends StatelessWidget {
  const PrivacyHeaderBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryColor.withValues(alpha: 0.22),
            AppColors.colorBtnAndCard,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Privacy shield icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.shield_outlined,
              color: AppColors.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(height: 16),

          // Headline — "Your Data," in white, "Protected." in green
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                height: 1.15,
              ),
              children: [
                const TextSpan(
                  text: 'Your Data,\n',
                  style: TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: 'Protected.',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Subtitle
          Text(
            'At Mala3bna, we prioritize your privacy as much as your performance. Learn how we handle your information to provide the best sports facility experience.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
