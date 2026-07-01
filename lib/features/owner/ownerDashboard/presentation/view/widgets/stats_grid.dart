import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/ownerDashboard/domain/entities/dashboard_entity.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/dashboard_stat_card.dart';
import 'package:mala3bna/features/owner/booking/presentation/cubit/booking_cubit.dart';
import 'package:mala3bna/features/owner/booking/presentation/cubit/booking_state.dart';
import 'package:mala3bna/features/owner/booking/domain/entities/booking_entity.dart';

/// 2×2 grid of dashboard statistic cards.
class StatsGrid extends StatelessWidget {
  final DashboardEntity data;

  const StatsGrid({super.key, required this.data});

  int _getTodaysBookings(List<BookingEntity> bookings) {
    final now = DateTime.now();
    int count = 0;
    for (var b in bookings) {
      final date = DateTime.tryParse(b.dateTime)?.toLocal();
      if (date != null &&
          date.year == now.year &&
          date.month == now.month &&
          date.day == now.day) {
        if (b.status == BookingStatus.approved) count++;
      }
    }
    return count;
  }

  double _getWeeklyEarnings(List<BookingEntity> bookings) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekStart = today.subtract(Duration(days: today.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 7));

    double earnings = 0;
    for (var b in bookings) {
      if (b.status == BookingStatus.approved) {
        final date = DateTime.tryParse(b.dateTime)?.toLocal();
        if (date != null && !date.isBefore(weekStart) && date.isBefore(weekEnd)) {
          earnings += double.tryParse(b.price) ?? 0;
        }
      }
    }
    return earnings;
  }

  int _getPendingRequests(List<BookingEntity> bookings) {
    return bookings.where((b) => b.status == BookingStatus.pending).length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section header ──
        Row(
          children: [
            Container(
              width: 3,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'OVERVIEW'.tr,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withValues(alpha: 0.4)
                    : Colors.black.withValues(alpha: 0.4),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // ── Cards ──
        BlocBuilder<BookingCubit, BookingState>(
          builder: (context, state) {
            int todaysBookings = data.todaysBookings;
            double weeklyEarnings = data.weeklyEarnings;
            int pendingRequests = data.pendingRequests;

            if (state is BookingLoaded) {
              final bookings = state.allBookings;
              todaysBookings = _getTodaysBookings(bookings);
              weeklyEarnings = _getWeeklyEarnings(bookings);
              pendingRequests = _getPendingRequests(bookings);
            }

            return GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.15,
              children: [
                DashboardStatCard(
                  title: "Today's Bookings",
                  value: '$todaysBookings',
                  icon: Icons.calendar_today_rounded,
                  accentColor: AppColors.primaryColor,
                ),
                DashboardStatCard(
                  title: 'Weekly Earnings',
                  value: '${'EGP'.tr} ${weeklyEarnings.toStringAsFixed(0)}',
                  icon: Icons.account_balance_wallet_outlined,
                  accentColor: const Color(0xFF5B8DEF),
                ),
                DashboardStatCard(
                  title: 'Pending Requests',
                  value: '$pendingRequests',
                  icon: Icons.pending_actions_rounded,
                  accentColor: const Color(0xFFF5A623),
                ),
                DashboardStatCard(
                  title: 'Total Courts',
                  value: '${data.totalCourts}',
                  icon: Icons.sports_soccer_rounded,
                  accentColor: const Color(0xFFE55C6C),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
