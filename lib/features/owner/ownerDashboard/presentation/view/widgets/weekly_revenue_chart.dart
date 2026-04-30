import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/model/owner_dashboard_model.dart';

class OwnerWeeklyRevenueChart extends StatelessWidget {
  final OwnerDashboardModel data;

  const OwnerWeeklyRevenueChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D24),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          const Text("Weekly Revenue", style: Style.textStyle14Bold),
          const SizedBox(height: 8),

          /// Amount
          Text("EGP ${data.weeklyEarnings.toStringAsFixed(0)}", style: Style.textStyle30Bold),

          const SizedBox(height: 4),

          /// Growth
          Text.rich(
            TextSpan(
              text: "Last 7 Days ",
              style: const TextStyle(color: Colors.white54),
              children: [
                TextSpan(
                  text: data.weeklyGrowthPercentage >= 0
                      ? "+${data.weeklyGrowthPercentage.toStringAsFixed(0)}%"
                      : "${data.weeklyGrowthPercentage.toStringAsFixed(0)}%",
                  style: TextStyle(
                    color: data.weeklyGrowthPercentage >= 0
                        ? AppColors.primaryColor
                        : Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          /// Chart
          SizedBox(height: 140, child: LineChart(_chartData())),
        ],
      ),
    );
  }

  LineChartData _chartData() {
    // Generate FlSpots from data.weeklyRevenueChart
    List<FlSpot> spots = data.weeklyRevenueChart.map((point) {
      return FlSpot(point.dayIndex.toDouble(), point.revenue);
    }).toList();

    return LineChartData(
      backgroundColor: Colors.transparent,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 24,
            getTitlesWidget: (value, meta) {
              const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

              if (value.toInt() >= 0 && value.toInt() < days.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    days[value.toInt()],
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          barWidth: 3,
          color: AppColors.primaryColor,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor.withOpacity(0.4),
                AppColors.primaryColor.withOpacity(0.05),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          spots: spots.isEmpty
              ? const [
                  FlSpot(0, 0), FlSpot(1, 0), FlSpot(2, 0),
                  FlSpot(3, 0), FlSpot(4, 0), FlSpot(5, 0), FlSpot(6, 0)
                ]
              : spots,
        ),
      ],
    );
  }
}
