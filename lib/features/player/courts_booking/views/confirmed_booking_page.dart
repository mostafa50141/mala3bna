import 'package:flutter/material.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/confirmed_booking_body_page.dart';

class ConfirmedBookingPage extends StatelessWidget {
  const ConfirmedBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: ConfirmedBookingBodyPage()));
  }
}
