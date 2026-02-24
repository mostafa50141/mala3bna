import 'package:flutter/material.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/dashboard_stat_card.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: const [
        DashboardStatCard(
          title: "Today's Bookings",
          value: "12",
          icon: Icons.calendar_today,
        ),
        DashboardStatCard(
          title: "Earnings This Week",
          value: "EGP 4,500",
          icon: Icons.attach_money,
        ),
        DashboardStatCard(
          title: "Pending Requests",
          value: "3",
          icon: Icons.notifications_active,
        ),
        DashboardStatCard(
          title: "Total Courts",
          value: "5",
          icon: Icons.sports_soccer,
        ),
      ],
    );
  }
}
