class RevenueDataPoint {
  final int dayIndex; // 0 for Mon, 6 for Sun
  final double revenue;

  RevenueDataPoint({required this.dayIndex, required this.revenue});
}

class OwnerDashboardModel {
  final String ownerName;
  final int todaysBookings;
  final double weeklyEarnings;
  final int pendingRequests;
  final int totalCourts;
  final List<RevenueDataPoint> weeklyRevenueChart;
  final double weeklyGrowthPercentage;

  OwnerDashboardModel({
    required this.ownerName,
    required this.todaysBookings,
    required this.weeklyEarnings,
    required this.pendingRequests,
    required this.totalCourts,
    required this.weeklyRevenueChart,
    required this.weeklyGrowthPercentage,
  });
}
