import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/cubit/owner_dashboard_cubit.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/cubit/owner_dashboard_state.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerDashboardCubit, OwnerDashboardState>(
      builder: (context, state) {
        String ownerName = "...";
        if (state is OwnerDashboardLoaded) {
          ownerName = state.dashboardData.ownerName;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFF1A1D24),
                child: Icon(Icons.person, color: Colors.white70),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Welcome, $ownerName",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(60, 87, 92, 102),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
