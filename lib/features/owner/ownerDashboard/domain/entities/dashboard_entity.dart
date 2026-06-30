import 'package:equatable/equatable.dart';

class RevenuePoint extends Equatable {
  final int dayIndex;
  final double revenue;

  const RevenuePoint({
    required this.dayIndex,
    required this.revenue,
  });

  @override
  List<Object?> get props => [dayIndex, revenue];
}

class DashboardEntity extends Equatable {
  final String ownerName;
  final int todaysBookings;
  final double weeklyEarnings;
  final int pendingRequests;
  final int totalCourts;
  final double weeklyGrowthPercentage;
  final List<RevenuePoint> weeklyRevenueChart;

  const DashboardEntity({
    required this.ownerName,
    required this.todaysBookings,
    required this.weeklyEarnings,
    required this.pendingRequests,
    required this.totalCourts,
    required this.weeklyGrowthPercentage,
    required this.weeklyRevenueChart,
  });

  @override
  List<Object?> get props => [
        ownerName,
        todaysBookings,
        weeklyEarnings,
        pendingRequests,
        totalCourts,
        weeklyGrowthPercentage,
        weeklyRevenueChart,
      ];
}
