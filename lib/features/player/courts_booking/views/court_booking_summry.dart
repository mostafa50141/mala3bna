import 'package:flutter/material.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/court_booking_summry_body.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';

class CourtBookingSummry extends StatelessWidget {
  final CourtModel court;
  final DateTime? selectedDate;
  final String? selectedTime;

  const CourtBookingSummry({super.key, required this.court, this.selectedDate, this.selectedTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CourtBookingSummryBody(
          court: court,
          selectedDate: selectedDate,
          selectedTime: selectedTime,
        ),
      ),
    );
  }
}
