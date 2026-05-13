import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class PaymentsSummaryCard extends StatelessWidget {
  final double totalSpent;
  final int transactionCount;

  const PaymentsSummaryCard({
    super.key,
    required this.totalSpent,
    required this.transactionCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Summary',
            style: Style.textStyle20Bold.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(
                'Total Spent',
                '$totalSpent EGP',
                AppColors.primaryColor,
              ),
              _buildStatItem('Transactions', '$transactionCount', Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Style.textStyle16.copyWith(color: Colors.white70)),
        const SizedBox(height: 4),
        Text(value, style: Style.textStyle18Bold.copyWith(color: valueColor)),
      ],
    );
  }
}
