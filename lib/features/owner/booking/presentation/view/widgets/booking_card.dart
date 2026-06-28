import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/booking/presentation/cubit/booking_cubit.dart';
import 'package:mala3bna/features/owner/booking/domain/entities/booking_entity.dart';
import 'package:mala3bna/features/owner/booking/presentation/view/widgets/top_info_booking_request_card.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    required this.booking,
    this.isProcessing = false,
  });

  final BookingEntity booking;
  final bool isProcessing;

  Color get _statusColor {
    switch (booking.status) {
      case BookingStatus.approved:
        return AppColors.primaryColor;
      case BookingStatus.declined:
        return Colors.redAccent;
      case BookingStatus.pending:
        return Colors.orange;
    }
  }

  String get _statusLabel {
    switch (booking.status) {
      case BookingStatus.approved:
        return 'Approved'.tr;
      case BookingStatus.declined:
        return 'Declined'.tr;
      case BookingStatus.pending:
        return 'Pending'.tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPending = booking.status == BookingStatus.pending;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _statusColor.withValues(alpha: 0.18),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Left accent bar
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 4,
              decoration: BoxDecoration(
                color: _statusColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.fromLTRB(18, 14, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar + name + status badge
                TopInfoAtBookingRequestCard(
                  booking: booking,
                  statusColor: _statusColor,
                  statusLabel: _statusLabel,
                ),

                const SizedBox(height: 10),
                Divider(
                    color: Colors.white.withValues(alpha: 0.07),
                    height: 1),
                const SizedBox(height: 10),

                // Date/time + price row
                Row(
                  children: [
                    Icon(Icons.access_time_rounded,
                        size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        booking.dateTime,
                        style: TextStyle(
                            color: Colors.grey[400], fontSize: 13),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        booking.price,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                // Action buttons (only for pending)
                if (isPending) ...[
                  const SizedBox(height: 14),
                  isProcessing
                      ? Center(
                          child: SizedBox(
                            height: 28,
                            width: 28,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: _ActionButton(
                                label: 'Decline'.tr,
                                icon: Icons.close_rounded,
                                color: Colors.redAccent,
                                outlined: true,
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  context
                                      .read<BookingCubit>()
                                      .declineBooking(booking.id);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${booking.playerName} - ${'booking declined'.tr}'),
                                      backgroundColor:
                                          Colors.redAccent.withValues(alpha: 0.9),
                                      behavior:
                                          SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      duration: const Duration(
                                          seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _ActionButton(
                                label: 'Accept'.tr,
                                icon: Icons.check_rounded,
                                color: AppColors.primaryColor,
                                outlined: false,
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  context
                                      .read<BookingCubit>()
                                      .acceptBooking(booking.id);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${booking.playerName} - ${'booking accepted ✓'.tr}'),
                                      backgroundColor:
                                          AppColors.primaryColor.withValues(alpha: 0.9),
                                      behavior:
                                          SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      duration: const Duration(
                                          seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool outlined;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.outlined,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (outlined) {
      return OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 16, color: color),
        label: Text(label,
            style: TextStyle(
                color: color, fontWeight: FontWeight.w600, fontSize: 13)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color.withValues(alpha: 0.6), width: 1),
          padding: const EdgeInsets.symmetric(vertical: 11),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16, color: Colors.white),
      label: Text(label,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 11),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
