import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/ownerDashboard/domain/entities/dashboard_entity.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/dashboard_stat_card.dart';

/// 2×2 grid of dashboard statistic cards.
class StatsGrid extends StatelessWidget {
  final DashboardEntity data;

  const StatsGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section header ──
        Row(
          children: [
            Container(
              width: 3,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'OVERVIEW'.tr,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // ── Cards ──
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.15,
          children: [
            DashboardStatCard(
              title: "Today's Bookings",
              value: '${data.todaysBookings}',
              icon: Icons.calendar_today_rounded,
              accentColor: AppColors.primaryColor,
            ),
            DashboardStatCard(
              title: 'Weekly Earnings',
              value: '${'EGP'.tr} ${data.weeklyEarnings.toStringAsFixed(0)}',
              icon: Icons.account_balance_wallet_outlined,
              accentColor: const Color(0xFF5B8DEF),
            ),
            DashboardStatCard(
              title: 'Pending Requests',
              value: '${data.pendingRequests}',
              icon: Icons.pending_actions_rounded,
              accentColor: const Color(0xFFF5A623),
            ),
            DashboardStatCard(
              title: 'Total Courts',
              value: '${data.totalCourts}',
              icon: Icons.sports_soccer_rounded,
              accentColor: const Color(0xFFE55C6C),
            ),
          ],
        ),
      ],
    );
  }
}
