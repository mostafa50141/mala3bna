import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Pricing", style: Style.textStyle16Bold),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                "Off-Peak Hours (8am - 5pm)",
                style: Style.textStyle14Bold.copyWith(color: Colors.grey),
              ),
              Spacer(),
              Text("EGP 250/hr", style: Style.textStyle14Bold),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                "Peak Hours (5pm - 12am)",
                style: Style.textStyle14Bold.copyWith(color: Colors.grey),
              ),
              Spacer(),
              Text("EGP 450/hr", style: Style.textStyle14Bold),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                "Membership Discount",
                style: Style.textStyle14Bold.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "-15%",
                style: Style.textStyle14Bold.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
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
