import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/ownerDashboard/data/owner_dashboard_repository.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/cubit/owner_dashboard_cubit.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/dashboard_app_bar.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/owner_dashboard_body.dart';

class OwnerDashboardView extends StatelessWidget {
  const OwnerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          OwnerDashboardCubit(OwnerDashboardRepository())..loadDashboard(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Column(
            children: const [
              DashboardAppBar(),
              Expanded(child: OwnerDashboardBody()),
            ],
          ),
        ),
      ),
    );
  }
}
