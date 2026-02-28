import 'package:flutter/material.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/court_details_body.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: CourtDetailsBody()));
  }
}
