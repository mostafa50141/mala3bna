import 'package:mala3bna/features/owner/ownerDashboard/domain/entities/dashboard_entity.dart';

abstract class OwnerDashboardState {}

class OwnerDashboardInitial extends OwnerDashboardState {}

class OwnerDashboardLoading extends OwnerDashboardState {}

class OwnerDashboardLoaded extends OwnerDashboardState {
  final DashboardEntity dashboardData;

  OwnerDashboardLoaded(this.dashboardData);
}

class OwnerDashboardError extends OwnerDashboardState {
  final String message;

  OwnerDashboardError(this.message);
}
