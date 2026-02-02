import 'package:flutter/material.dart';
import 'package:mala3bna/features/courts_booking/views/widgets/court_booking_summry_body.dart';

class CourtBookingSummry extends StatelessWidget {
  const CourtBookingSummry({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: CourtBookingSummryBody()));
  }
}
