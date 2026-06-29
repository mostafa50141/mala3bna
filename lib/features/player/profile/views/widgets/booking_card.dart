import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/courts_booking/data/models/booking_model.dart';
import 'package:mala3bna/features/player/courts_booking/presentation/cubit/booking_cubit.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final bool showCancel;

  const BookingCard({
    super.key,
    required this.booking,
    required this.showCancel,
  });

  Color _statusColor(String status) {
    switch (status) {
      case 'confirmed':
        return AppColors.primaryColor;
      case 'cancelled':
        return Colors.red;
      case 'pending':
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.colorBtnAndCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header row: image + info ──────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    booking.courtImage,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 80,
                      height: 80,
                      color: AppColors.colorBtnAndCard,
                      child: const Icon(Icons.sports_soccer, color: Colors.grey),
                    ),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Court name
                      Text(
                        booking.courtName,
                        style:
                            Style.textStyle14Bold.copyWith(color: Colors.white),
                      ),
                      const Gap(4),
                      // Sport chip
                      if (booking.sport.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            booking.sport,
                            style: Style.textStyle12
                                .copyWith(color: AppColors.primaryColor),
                          ),
                        ),
                      const Gap(4),
                      // Date
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 12, color: Colors.grey),
                          const Gap(4),
                          Text(
                            booking.date,
                            style: Style.textStyle12
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      const Gap(4),
                      // Time
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 12, color: Colors.grey),
                          const Gap(4),
                          Expanded(
                            child: Text(
                              booking.timeDisplay,
                              style: Style.textStyle12
                                  .copyWith(color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Status chip (top-right)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusColor(booking.status).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    booking.status,
                    style: Style.textStyle12.copyWith(
                      color: _statusColor(booking.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(10),
            // ── Footer row: price + cancel ────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking.priceDisplay,
                  style: Style.textStyle14Bold
                      .copyWith(color: AppColors.primaryColor),
                ),
                if (showCancel)
                  ElevatedButton(
                    onPressed: booking.id == null
                        ? null
                        : () {
                            context
                                .read<BookingCubit>()
                                .cancelBooking(bookingId: booking.id!);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.15),
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('Cancel'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
