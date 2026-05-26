import 'package:flutter/material.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/court_details_body.dart';

class BookingsView extends StatelessWidget {
  final CourtModel courtModel;
  const BookingsView({super.key, required this.courtModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: CourtDetailsBody(court: courtModel)),
    );
  }
}
