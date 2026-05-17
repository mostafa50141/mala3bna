import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

class HelpCenterDirectSupport extends StatelessWidget {
  const HelpCenterDirectSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryColor.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Direct Support',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'ONLINE NOW',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Chat with our athletic support\nteam',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_bubble_outline, size: 18),
                  label: const Text('Start Chat'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.email_outlined,
                      size: 18, color: AppColors.primaryColor),
                  label: Text('Email Us',
                      style: TextStyle(color: AppColors.primaryColor)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: AppColors.primaryColor.withValues(alpha: 0.5)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
