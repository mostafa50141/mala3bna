import 'package:flutter/material.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/confirmed_booking_body_page.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';

class ConfirmedBookingPage extends StatelessWidget {
  final CourtModel court;
  final DateTime? selectedDate;
  final String? selectedTime;
  final int? bookingId;

  const ConfirmedBookingPage({
    super.key,
    required this.court,
    this.selectedDate,
    this.selectedTime, this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ConfirmedBookingBodyPage(
          court: court,
          selectedDate: selectedDate,
          selectedTime: selectedTime,
        ),
      ),
    );
  }
}
