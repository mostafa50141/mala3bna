import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/owner/ownerDashboard/domain/repositories/dashboard_repository.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/cubit/owner_dashboard_cubit.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/dashboard_app_bar.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/owner_dashboard_body.dart';

class OwnerDashboardView extends StatelessWidget {
  final VoidCallback? onCourtAdded;
  const OwnerDashboardView({super.key, this.onCourtAdded});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          OwnerDashboardCubit(getIt<DashboardRepository>())..loadDashboard(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              const DashboardAppBar(),
              Expanded(child: OwnerDashboardBody(onCourtAdded: onCourtAdded)),
            ],
          ),
        ),
      ),
    );
  }
}
