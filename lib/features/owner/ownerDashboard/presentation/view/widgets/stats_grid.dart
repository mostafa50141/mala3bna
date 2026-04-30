import 'package:flutter/material.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/model/owner_dashboard_model.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/dashboard_stat_card.dart';

class StatsGrid extends StatelessWidget {
  final OwnerDashboardModel data;

  const StatsGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        DashboardStatCard(
          title: "Today's Bookings",
          value: "${data.todaysBookings}",
          icon: Icons.calendar_today,
        ),
        DashboardStatCard(
          title: "Earnings This Week",
          value: "EGP ${data.weeklyEarnings.toStringAsFixed(0)}",
          icon: Icons.attach_money,
        ),
        DashboardStatCard(
          title: "Pending Requests",
          value: "${data.pendingRequests}",
          icon: Icons.notifications_active,
        ),
        DashboardStatCard(
          title: "Total Courts",
          value: "${data.totalCourts}",
          icon: Icons.sports_soccer,
        ),
      ],
    );
  }
}
