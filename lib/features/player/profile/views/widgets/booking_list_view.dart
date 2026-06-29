import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/courts_booking/data/models/booking_model.dart';
import 'package:mala3bna/features/player/profile/views/widgets/booking_card.dart';

class BookingListView extends StatelessWidget {
  final List<BookingModel> bookings;
  final bool showCancel;

  const BookingListView({
    super.key,
    required this.bookings,
    required this.showCancel,
  });

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey.shade600,
              size: 48,
            ),
            const Gap(16),
            Text(
              'No bookings here',
              style: Style.textStyle14.copyWith(color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemCount: bookings.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: BookingCard(
          booking: bookings[index],
          showCancel: showCancel,
        ),
      ),
    );
  }
}
