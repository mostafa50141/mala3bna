import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/court_profile_cubit.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/court_profile_state.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/shared/section_card.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourtProfileCubit, CourtProfileState>(
      builder: (context, state) {
        CourtEntity? court;
        if (state is CourtProfileLoaded) court = state.courtProfile;

        final offPeak = court?.offPeakRate ?? 0.0;
        final peak = court?.peakRate ?? court?.hourlyRate ?? 0.0;
        final discount = court?.membershipDiscount ?? 0.0;

        return SectionCard(
          accentLeft: BorderSide(color: AppColors.primaryColor, width: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: 'Pricing'.tr,
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: AppColors.primaryColor.withValues(alpha: 0.35)),
                  ),
                  child: Text(
                    'Per Hour'.tr,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _PriceRow(
                icon: Icons.wb_sunny_outlined,
                iconColor: Colors.amber.shade300,
                label: 'Off-Peak Hours'.tr,
                subtitle: '11 am – 5 pm'.tr,
                price: offPeak > 0 ? '${offPeak.toStringAsFixed(0)} ${'EGP'.tr}${'/hr'.tr}' : '—',
                priceColor: Colors.white,
              ),
              _divider(),
              _PriceRow(
                icon: Icons.nightlight_outlined,
                iconColor: const Color(0xFFB39DDB),
                label: 'Peak Hours'.tr,
                subtitle: '5 pm – 10 pm'.tr,
                price: peak > 0 ? '${peak.toStringAsFixed(0)} ${'EGP'.tr}${'/hr'.tr}' : '—',
                priceColor: Colors.white,
              ),
              _divider(),
              _PriceRow(
                icon: Icons.local_offer_outlined,
                iconColor: AppColors.primaryColor,
                label: 'Membership Discount'.tr,
                subtitle: 'For registered members'.tr,
                price: discount > 0 ? '−${discount.toStringAsFixed(0)}%' : '—',
                priceColor: AppColors.primaryColor,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _divider() => const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Divider(color: Colors.white10, height: 1),
      );
}

class _PriceRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String subtitle;
  final String price;
  final Color priceColor;

  const _PriceRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.subtitle,
    required this.price,
    required this.priceColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
        ),
        Text(
          price,
          style: TextStyle(
              color: priceColor, fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
