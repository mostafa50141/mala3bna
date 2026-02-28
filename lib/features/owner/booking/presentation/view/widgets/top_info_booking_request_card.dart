import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/owner/booking/presentation/model/booking_request_model.dart';

class TopInfoAtBookingRequestCard extends StatelessWidget {
  final BookingRequest booking;

  const TopInfoAtBookingRequestCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final isApproved = booking.status == BookingStatus.approved;

    return Row(
      children: [
        CircleAvatar(radius: 24, backgroundImage: NetworkImage(booking.avatar)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.name,
                style: Style.textStyle14Bold.copyWith(color: Colors.white),
              ),
              Text(
                "${booking.sport} • ${booking.duration}",
                style: Style.textStyle14.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: isApproved
                ? AppColors.primaryColor.withOpacity(.15)
                : Colors.orange.withOpacity(.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            isApproved ? "Approved" : "Pending",
            style: Style.textStyle12Bold.copyWith(
              color: isApproved ? AppColors.primaryColor : Colors.orange,
            ),
          ),
        ),
      ],
    );
  }
}
