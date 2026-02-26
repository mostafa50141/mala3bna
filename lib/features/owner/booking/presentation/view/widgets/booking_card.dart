import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';
import 'package:mala3bna/features/owner/booking/presentation/model/booking_request_model.dart';
import 'package:mala3bna/features/owner/booking/presentation/view/widgets/top_info_booking_request_card.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key, required this.booking});
  final BookingRequest booking;

  @override
  Widget build(BuildContext context) {
    final isPending = booking.status == BookingStatus.pending;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopInfoAtBookingRequestCard(booking: booking),
          const SizedBox(height: 5),
          Divider(color: Colors.grey.withOpacity(0.2)),
          Text(
            booking.dateTime,
            style: Style.textStyle14.copyWith(color: Colors.grey),
          ),

          if (isPending) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomBtn(
                    text: "Decline",
                    height: 45,
                    width: double.infinity,
                    radius: 25,
                    color: const Color(0xFF2D333B),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomBtn(
                    text: "Accept",
                    height: 45,
                    width: double.infinity,
                    radius: 25,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
