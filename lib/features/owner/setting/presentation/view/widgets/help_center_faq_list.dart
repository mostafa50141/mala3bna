import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

class HelpCenterFaqList extends StatelessWidget {
  const HelpCenterFaqList({super.key});

  final List<Map<String, String>> faqs = const [
    {
      'question': 'How can I cancel a pitch booking?',
      'answer':
          'To cancel a booking, go to the "Bookings" tab, select your upcoming match, and tap "Cancel Booking". Please note our 24-hour cancellation policy applies for full refunds.',
    },
    {
      'question': 'Where can I find my match statistics?',
      'answer':
          'Your match statistics are available in your Profile under the "Stats" section. This updates automatically after each confirmed match.',
    },
    {
      'question': 'Why is my payment still pending?',
      'answer':
          'Payments may take up to 2-3 business days to process depending on your bank. If it remains pending longer, please contact our support team.',
    },
    {
      'question': 'How to invite friends to a match?',
      'answer':
          'Open your scheduled match details and tap the "Invite Friends" button. You can share a direct link via WhatsApp, SMS, or copy the link.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Popular Questions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...faqs.map((faq) => _FaqTile(
              question: faq['question']!,
              answer: faq['answer']!,
            )),
      ],
    );
  }
}

class _FaqTile extends StatefulWidget {
  final String question;
  final String answer;

  const _FaqTile({required this.question, required this.answer});

  @override
  State<_FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<_FaqTile>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.white.withValues(alpha: 0.05),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.colorBtnAndCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isExpanded
                    ? AppColors.primaryColor.withValues(alpha: 0.3)
                    : Colors.transparent,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.question,
                        style: TextStyle(
                          color: _isExpanded
                              ? AppColors.primaryColor
                              : Colors.white.withValues(alpha: 0.8),
                          fontSize: 14,
                          fontWeight:
                              _isExpanded ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: _isExpanded ? 0.25 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: _isExpanded
                            ? AppColors.primaryColor
                            : Colors.white.withValues(alpha: 0.3),
                        size: 14,
                      ),
                    ),
                  ],
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: SizedBox(
                    width: double.infinity,
                    child: _isExpanded
                        ? Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              widget.answer,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
