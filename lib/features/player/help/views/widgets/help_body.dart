import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/help/views/widgets/help_faq_item.dart';

class HelpBody extends StatelessWidget {
  const HelpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar (UI only)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.colorBtnAndCard,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search for help...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.white54),
              ),
            ),
          ),
          const Gap(24),
          
          // FAQ Section
          Text(
            'FAQ',
            style: Style.textStyle16Bold.copyWith(color: Colors.white),
          ),
          const Gap(16),
          const HelpFaqItem(
            question: 'How do I book a court?',
            answer: 'To book a court, go to the Home screen, browse available courts, select a court, choose an available date and time slot, and proceed to payment.',
          ),
          const HelpFaqItem(
            question: 'How do I cancel a booking?',
            answer: 'You can cancel a booking from the My Bookings section. Tap on an upcoming booking and select Cancel. Note that cancellations must be made 24 hours in advance.',
          ),
          const HelpFaqItem(
            question: 'What payment methods are accepted?',
            answer: 'We accept major credit cards (Visa, MasterCard) as well as Vodafone Cash and other local e-wallets.',
          ),
          const HelpFaqItem(
            question: 'How do I contact court owner?',
            answer: 'You can find the court owner\'s contact details in the specific court profile or from your confirmed booking details.',
          ),
          const HelpFaqItem(
            question: 'How do I change my profile info?',
            answer: 'Navigate to Settings from the Profile tab, and select Edit Profile to update your personal information.',
          ),
          const Gap(24),
          
          // Contact Us Section
          Text(
            'Contact Us',
            style: Style.textStyle16Bold.copyWith(color: Colors.white),
          ),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.colorBtnAndCard,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.email_outlined, color: AppColors.primaryColor),
                const Gap(16),
                Expanded(
                  child: Text(
                    'support@mala3bna.com',
                    style: Style.textStyle14.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.colorBtnAndCard,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.phone_outlined, color: AppColors.primaryColor),
                const Gap(16),
                Expanded(
                  child: Text(
                    '+20 100 000 0000',
                    style: Style.textStyle14.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const Gap(24),
        ],
      ),
    );
  }
}
