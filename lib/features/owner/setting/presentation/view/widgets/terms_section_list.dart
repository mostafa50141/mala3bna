import 'package:flutter/material.dart';
import 'package:mala3bna/features/owner/setting/domain/terms_section.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/terms_section_card.dart';

/// The full list of terms sections, each rendered as an expandable card.
class TermsSectionList extends StatelessWidget {
  const TermsSectionList({super.key});

  // ─── Content ────────────────────────────────────────────────────────
  static const List<TermsSection> _sections = [
    TermsSection(
      number: 1,
      title: 'Introduction',
      points: [
        'Welcome to Mala3bna (Neon Athletics). These Terms and Conditions govern your use of our sports facility management platform.',
        'By accessing our services, you agree to be bound by these Terms. Our platform serves as a bridge between facility owners and players.',
        'Users must be at least 18 years old or have parental consent to create an account and use our services.',
      ],
    ),
    TermsSection(
      number: 2,
      title: 'Booking Policy',
      points: [
        'Cancellations must be made more than 24 hours before the booking time to be eligible for a full refund.',
        'Payment Terms: Payment must be completed at the time of booking. We accept all major credit cards and mobile payment solutions.',
        'No-shows are charged the full booking amount. Repeated no-shows may result in account suspension.',
        'Facility owners reserve the right to cancel bookings due to maintenance or unforeseen circumstances.',
      ],
    ),
    TermsSection(
      number: 3,
      title: 'User Conduct',
      points: [
        'The Mala3bna community is built on mutual respect. Users are expected to maintain fair play and sportsmanship at all times.',
        'Abusive language, harassment, or discriminatory behaviour towards other users or facility staff will not be tolerated.',
        'Any attempt to manipulate ratings, reviews, or booking systems is strictly prohibited.',
        'We reserve the right to suspend accounts that violate our community guidelines without prior notice.',
      ],
    ),
    TermsSection(
      number: 4,
      title: 'Privacy Policy Summary',
      points: [
        'We collect only the data necessary to provide our services, including profile information, booking history, and payment details.',
        'Your personal data is never sold to third parties. We share information only with facility partners required to complete your booking.',
        'You have the right to request a copy of your data or request its deletion at any time via the settings menu.',
      ],
    ),
    TermsSection(
      number: 5,
      title: 'Limitation of Liability',
      points: [
        'Mala3bna acts as an intermediary between users and facility owners. We are not liable for injuries sustained on facility grounds.',
        'We are not responsible for any loss of personal belongings during your time at a facility.',
        'Our maximum liability is limited to the amount paid for the specific booking in question.',
        'By continuing to use our platform, you acknowledge and accept these limitations.',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _sections
          .map(
            (section) => TermsSectionCard(
              section: section,
              initiallyExpanded: section.number == 1,
            ),
          )
          .toList(),
    );
  }
}
