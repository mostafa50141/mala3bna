import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pricing',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _priceRow(
            label: 'Off-Peak Hours (11am - 5pm)',
            price: 'EGP 300/hr',
            priceColor: Colors.white,
          ),
          const SizedBox(height: 10),
          _priceRow(
            label: 'Peak Hours (5pm - 10am)',
            price: 'EGP 460/hr',
            priceColor: Colors.white,
          ),
          const SizedBox(height: 10),
          _priceRow(
            label: 'Membership Discount',
            price: '-15%',
            labelColor: AppColors.primaryColor,
            priceColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _priceRow({
    required String label,
    required String price,
    Color labelColor = const Color(0xFFAAAAAA),
    Color priceColor = Colors.white,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: labelColor, fontSize: 13),
          ),
        ),
        Text(
          price,
          style: TextStyle(
            color: priceColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
