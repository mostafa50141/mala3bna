import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/cubit/owner_dashboard_cubit.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/cubit/owner_dashboard_state.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/add_court_button.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/dashboard_error_view.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/dashboard_loading_view.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/stats_grid.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/weekly_revenue_chart.dart';

/// Main scrollable content area of the owner dashboard.
/// Switches between loading / error / loaded states via the Cubit.
class OwnerDashboardBody extends StatelessWidget {
  const OwnerDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerDashboardCubit, OwnerDashboardState>(
      builder: (context, state) {
        // ── Loading ──
        if (state is OwnerDashboardLoading || state is OwnerDashboardInitial) {
          return const DashboardLoadingView();
        }

        // ── Error ──
        if (state is OwnerDashboardError) {
          return DashboardErrorView(
            message: state.message,
            onRetry: () =>
                context.read<OwnerDashboardCubit>().loadDashboard(),
          );
        }

        // ── Loaded ──
        if (state is OwnerDashboardLoaded) {
          final data = state.dashboardData;

          return RefreshIndicator(
            onRefresh: () =>
                context.read<OwnerDashboardCubit>().loadDashboard(),
            color: Colors.white,
            backgroundColor: const Color(0xFF1A1D24),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                const SizedBox(height: 4),
                StatsGrid(data: data),
                const SizedBox(height: 24),
                OwnerWeeklyRevenueChart(data: data),
                const SizedBox(height: 20),
                const AddCourtButton(),
                const SizedBox(height: 24),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
