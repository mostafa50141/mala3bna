import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mala3bna/features/owner/setting/domain/privacy_section.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/privacy_section_card.dart';

/// Renders the full list of privacy policy sections.
/// Content is defined as a const list — swap for a repository call if needed.
class PrivacySectionList extends StatelessWidget {
  const PrivacySectionList({super.key});

  static List<PrivacySection> get _sections => [
    PrivacySection(
      icon: Icons.storage_outlined,
      title: 'Data Collection'.tr,
      body:
          'We collect essential information to facilitate your experience, including your name, email address, and location services to find nearby courts. All data collection is transparent and consensual.'.tr,
    ),
    PrivacySection(
      icon: Icons.bar_chart_rounded,
      title: 'Usage'.tr,
      body:
          'Your data helps us streamline bookings, verify schedules, and improve platform performance through personalised recommendations and facility management tools. We only use data to enhance your in-app experience.'.tr,
    ),
    PrivacySection(
      icon: Icons.lock_outline_rounded,
      title: 'Security & Encryption'.tr,
      badge: 'SSL SECURE'.tr,
      body:
          'All payment information is processed through end-to-end encrypted gateways. We never store your full credit card details on our servers, ensuring your financial integrity remains untouched.'.tr,
    ),
    PrivacySection(
      icon: Icons.group_outlined,
      title: 'Third-Party Policy'.tr,
      body:
          'We maintain a strict No-Sale Policy. Your personal data is never traded or sold to third-party advertisers. Information is only shared with court owners to confirm your specific bookings.'.tr,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _sections
          .map((section) => PrivacySectionCard(section: section))
          .toList(),
    );
  }
}
