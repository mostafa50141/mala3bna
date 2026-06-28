import 'package:flutter/material.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/owner/booking/domain/entities/booking_entity.dart';

class TopInfoAtBookingRequestCard extends StatelessWidget {
  final BookingEntity booking;
  final Color statusColor;
  final String statusLabel;

  const TopInfoAtBookingRequestCard({
    super.key,
    required this.booking,
    required this.statusColor,
    required this.statusLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey[800],
          backgroundImage: booking.avatarUrl.isNotEmpty
              ? NetworkImage(booking.avatarUrl)
              : null,
          child: booking.avatarUrl.isEmpty
              ? const Icon(Icons.person, color: Colors.white70)
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.playerName,
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
            color: statusColor.withValues(alpha: .15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            statusLabel,
            style: Style.textStyle12Bold.copyWith(
              color: statusColor,
            ),
          ),
        ),
      ],
    );
  }
}
