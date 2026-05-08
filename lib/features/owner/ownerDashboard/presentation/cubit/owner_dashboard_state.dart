import 'package:mala3bna/features/owner/ownerDashboard/presentation/model/owner_dashboard_model.dart';

abstract class OwnerDashboardState {}

class OwnerDashboardInitial extends OwnerDashboardState {}

class OwnerDashboardLoading extends OwnerDashboardState {}

class OwnerDashboardLoaded extends OwnerDashboardState {
  final OwnerDashboardModel dashboardData;

  OwnerDashboardLoaded(this.dashboardData);
}

class OwnerDashboardError extends OwnerDashboardState {
  final String message;

  OwnerDashboardError(this.message);
}
