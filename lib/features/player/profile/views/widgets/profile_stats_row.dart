import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard('12', 'Bookings'),
        _buildStatCard('Padel', 'Fav Sport'),
        _buildStatCard('2024', 'Member Since'),
      ],
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Style.textStyle20Bold.copyWith(color: Colors.white),
          ),
          const Gap(4),
          Text(
            label,
            style: Style.textStyle12.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
