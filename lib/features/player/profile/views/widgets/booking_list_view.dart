import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/courts_booking/data/models/booking_model.dart';
import 'package:mala3bna/features/player/profile/views/widgets/booking_card.dart';

class BookingListView extends StatelessWidget {
  final List<BookingModel> bookings;
  final VoidCallback onBookingCancelled;

  const BookingListView({
    super.key,
    required this.bookings,
    required this.onBookingCancelled,
  });

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey,
              size: 60,
            ),
            const Gap(16),
            Text(
              'No bookings yet',
              style: Style.textStyle16.copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: BookingCard(
            booking: booking,
            onBookingCancelled: onBookingCancelled,
          ),
        );
      },
    );
  }
}
