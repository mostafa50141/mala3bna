import 'package:mala3bna/features/owner/ownerDashboard/presentation/model/owner_dashboard_model.dart';

class OwnerDashboardRepository {
  Future<OwnerDashboardModel> fetchDashboardData() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return OwnerDashboardModel(
      ownerName: "Mohamed",
      todaysBookings: 12,
      weeklyEarnings: 4500.0,
      pendingRequests: 3,
      totalCourts: 5,
      weeklyGrowthPercentage: 15.0,
      weeklyRevenueChart: [
        RevenueDataPoint(dayIndex: 0, revenue: 3000), // Mon
        RevenueDataPoint(dayIndex: 1, revenue: 5000), // Tue
        RevenueDataPoint(dayIndex: 2, revenue: 2000), // Wed
        RevenueDataPoint(dayIndex: 3, revenue: 4000), // Thu
        RevenueDataPoint(dayIndex: 4, revenue: 1000), // Fri
        RevenueDataPoint(dayIndex: 5, revenue: 6000), // Sat
        RevenueDataPoint(dayIndex: 6, revenue: 3000), // Sun
      ],
    );
  }
}
