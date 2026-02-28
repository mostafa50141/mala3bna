import 'package:flutter/material.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/add_court_button.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/stats_grid.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/weekly_revenue_chart.dart';

class OwnerDashboardBody extends StatelessWidget {
  const OwnerDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const StatsGrid(),
          const SizedBox(height: 24),
          OwnerWeeklyRevenueChart(),
          const SizedBox(height: 10),
          const AddCourtButton(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
