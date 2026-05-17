import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

class HelpCenterCategories extends StatelessWidget {
  const HelpCenterCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: const [
        _CategoryCard(
          title: 'Payments',
          subtitle: 'Refunds & Pricing',
          icon: Icons.payments_outlined,
        ),
        _CategoryCard(
          title: 'Bookings',
          subtitle: 'Manage Schedule',
          icon: Icons.calendar_today_outlined,
        ),
        _CategoryCard(
          title: 'Security',
          subtitle: 'Privacy & Data',
          icon: Icons.shield_outlined,
        ),
        _CategoryCard(
          title: 'Facilities',
          subtitle: 'Venue Support',
          icon: Icons.sports_soccer_outlined,
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        splashColor: AppColors.primaryColor.withValues(alpha: 0.1),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.colorBtnAndCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primaryColor, size: 22),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
