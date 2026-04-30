import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/cubit/owner_dashboard_cubit.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/cubit/owner_dashboard_state.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/add_court_button.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/stats_grid.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/weekly_revenue_chart.dart';

class OwnerDashboardBody extends StatelessWidget {
  const OwnerDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerDashboardCubit, OwnerDashboardState>(
      builder: (context, state) {
        if (state is OwnerDashboardLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }

        if (state is OwnerDashboardError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.grey[600], size: 52),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => context.read<OwnerDashboardCubit>().loadDashboard(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is OwnerDashboardLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                StatsGrid(data: state.dashboardData),
                const SizedBox(height: 24),
                OwnerWeeklyRevenueChart(data: state.dashboardData),
                const SizedBox(height: 10),
                const AddCourtButton(),
                const SizedBox(height: 10),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
