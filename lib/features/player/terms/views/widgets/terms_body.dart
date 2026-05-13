import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/terms/views/widgets/terms_section.dart';

class TermsBody extends StatelessWidget {
  const TermsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Last updated: May 11, 2026',
            style: Style.textStyle14.copyWith(color: Colors.grey),
          ),
          const Gap(24),
          const TermsSection(
            title: '1. Acceptance of Terms',
            content: 'By accessing and using this application, you accept and agree to be bound by the terms and provision of this agreement. In addition, when using these particular services, you shall be subject to any posted guidelines or rules applicable to such services.',
          ),
          const TermsSection(
            title: '2. Use of the App',
            content: 'You agree to use the app only for lawful purposes. You must not use the app in any way that causes, or may cause, damage to the app or impairment of the availability or accessibility of the app.',
          ),
          const TermsSection(
            title: '3. Booking & Cancellation Policy',
            content: 'All bookings are subject to availability. Cancellations must be made at least 24 hours in advance to receive a full refund. Late cancellations may be subject to a fee.',
          ),
          const TermsSection(
            title: '4. Payment Terms',
            content: 'All payments are securely processed through our integrated payment gateways. Prices for court bookings and coaching sessions are displayed within the app and are subject to change without notice.',
          ),
          const TermsSection(
            title: '5. Privacy Policy',
            content: 'Your privacy is important to us. Our Privacy Policy explains how we collect, use, protect, and when we share personal information and other data with third parties.',
          ),
          const TermsSection(
            title: '6. Contact Us',
            content: 'If you have any questions about these Terms, please contact us at support@mala3bna.com.',
          ),
        ],
      ),
    );
  }
}
