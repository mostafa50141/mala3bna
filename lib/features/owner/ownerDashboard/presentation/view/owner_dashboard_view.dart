import 'package:flutter/material.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/dashboard_app_bar.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/owner_dashboard_body.dart';

class OwnerDashboardView extends StatelessWidget {
  const OwnerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            DashboardAppBar(),
            SizedBox(height: 2),
            Expanded(child: OwnerDashboardBody()),
          ],
        ),
      ),
    );
  }
}
