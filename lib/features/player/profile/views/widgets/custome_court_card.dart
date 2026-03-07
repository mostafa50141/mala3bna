import 'package:flutter/material.dart';
import 'package:mala3bna/features/player/profile/models/my_booking_court_card_model.dart';

class CustomeCourtCard extends StatelessWidget {
  const CustomeCourtCard({super.key, required this.myBookingCourtCardModel});
  final MyBookingCourtCardModel myBookingCourtCardModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              myBookingCourtCardModel.image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              myBookingCourtCardModel.title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
