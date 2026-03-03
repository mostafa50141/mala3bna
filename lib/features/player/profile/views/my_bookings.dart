import 'package:flutter/material.dart';
import 'package:mala3bna/features/player/profile/views/widgets/my_booking_body.dart';

class MyBookings extends StatelessWidget {
  const MyBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: const MyBookingBody()));
  }
}
