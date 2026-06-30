import 'package:mala3bna/features/owner/ownerDashboard/domain/entities/dashboard_entity.dart';

class DashboardModel {
  final String ownerName;
  final int todaysBookings;
  final double weeklyEarnings;
  final int pendingRequests;
  final int totalCourts;
  final double weeklyGrowthPercentage;
  final List<RevenuePoint> weeklyRevenueChart;

  DashboardModel({
    required this.ownerName,
    required this.todaysBookings,
    required this.weeklyEarnings,
    required this.pendingRequests,
    required this.totalCourts,
    required this.weeklyGrowthPercentage,
    required this.weeklyRevenueChart,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    var chartJson = json['weekly_revenue_chart'] as List? ?? [];
    List<RevenuePoint> chart = chartJson.map((point) {
      return RevenuePoint(
        dayIndex: point['day_index'] ?? 0,
        revenue: (point['revenue'] ?? 0).toDouble(),
      );
    }).toList();

    return DashboardModel(
      ownerName: json['owner_name'] ?? 'Owner',
      todaysBookings: json['todays_bookings'] ?? 0,
      weeklyEarnings: (json['weekly_earnings'] ?? 0).toDouble(),
      pendingRequests: json['pending_requests'] ?? 0,
      totalCourts: json['total_courts'] ?? 0,
      weeklyGrowthPercentage: (json['weekly_growth_percentage'] ?? 0).toDouble(),
      weeklyRevenueChart: chart,
    );
  }

  DashboardEntity toEntity() {
    return DashboardEntity(
      ownerName: ownerName,
      todaysBookings: todaysBookings,
      weeklyEarnings: weeklyEarnings,
      pendingRequests: pendingRequests,
      totalCourts: totalCourts,
      weeklyGrowthPercentage: weeklyGrowthPercentage,
      weeklyRevenueChart: weeklyRevenueChart,
    );
  }
}
