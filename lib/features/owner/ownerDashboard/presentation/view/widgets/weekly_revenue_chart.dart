import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/ownerDashboard/domain/entities/dashboard_entity.dart';

/// Weekly revenue line chart with gradient fill, growth badge, and styled axes.
class OwnerWeeklyRevenueChart extends StatelessWidget {
  final DashboardEntity data;

  const OwnerWeeklyRevenueChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isPositive = data.weeklyGrowthPercentage >= 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.05) ?? Colors.white.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header Row ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weekly Revenue'.tr,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5) ?? Colors.white.withValues(alpha: 0.5),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${'EGP'.tr} ${data.weeklyEarnings.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              // Growth badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: (isPositive ? AppColors.primaryColor : Colors.redAccent)
                      .withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color:
                        (isPositive ? AppColors.primaryColor : Colors.redAccent)
                            .withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      size: 14,
                      color: isPositive
                          ? AppColors.primaryColor
                          : Colors.redAccent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${isPositive ? '+' : ''}${data.weeklyGrowthPercentage.toStringAsFixed(0)}%',
                      style: TextStyle(
                        color: isPositive
                            ? AppColors.primaryColor
                            : Colors.redAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // ── Subtitle ──
          Text(
            'Last 7 days'.tr,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.3) ?? Colors.white.withValues(alpha: 0.3),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 24),

          // ── Chart ──
          SizedBox(height: 150, child: LineChart(_chartData(context))),
        ],
      ),
    );
  }

  // ─── Chart configuration ────────────────────────────────────────────

  LineChartData _chartData(BuildContext context) {
    final spots = data.weeklyRevenueChart
        .map((p) => FlSpot(p.dayIndex.toDouble(), p.revenue))
        .toList();

    return LineChartData(
      backgroundColor: Colors.transparent,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 2000,
        getDrawingHorizontalLine: (_) => FlLine(
          color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.04) ?? Colors.white.withValues(alpha: 0.04),
          strokeWidth: 1,
        ),
      ),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            getTitlesWidget: (value, meta) => _bottomLabel(value, meta, context),
          ),
        ),
      ),
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (_) => Theme.of(context).cardColor,
          tooltipBorder: BorderSide(
            color: AppColors.primaryColor.withValues(alpha: 0.3),
          ),
          getTooltipItems: (touchedSpots) => touchedSpots.map((spot) {
            return LineTooltipItem(
              '${'EGP'.tr} ${spot.y.toStringAsFixed(0)}',
              TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            );
          }).toList(),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          curveSmoothness: 0.32,
          barWidth: 3,
          color: AppColors.primaryColor,
          dotData: FlDotData(
            show: true,
            getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
              radius: 3.5,
              color: AppColors.primaryColor,
              strokeWidth: 2,
              strokeColor: Theme.of(context).cardColor,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor.withValues(alpha: 0.3),
                AppColors.primaryColor.withValues(alpha: 0.02),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          spots: spots.isEmpty ? _emptySpots : spots,
        ),
      ],
    );
  }

  Widget _bottomLabel(double value, TitleMeta meta, BuildContext context) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final index = value.toInt();
    if (index < 0 || index >= days.length) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        days[index].tr,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.35) ?? Colors.white.withValues(alpha: 0.35),
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static const List<FlSpot> _emptySpots = [
    FlSpot(0, 0), FlSpot(1, 0), FlSpot(2, 0),
    FlSpot(3, 0), FlSpot(4, 0), FlSpot(5, 0), FlSpot(6, 0),
  ];
}
