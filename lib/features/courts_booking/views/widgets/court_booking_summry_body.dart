import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/features/courts_booking/views/widgets/booking_summary_card.dart';
import 'package:mala3bna/features/courts_booking/views/widgets/custom_app_bar_court.dart';

class CourtBookingSummryBody extends StatelessWidget {
  const CourtBookingSummryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBarCourt(title: "Booking Summary"),
          const Gap(20),
          BookingSummaryCard(
            imageUrl: 'assets/images/Court.png',
            courtTitle: "Sky Padel - Court1",
            location: " Zamalek , Cairo  ",
            dateLabel: " Date",
            timeLabel: " Time ",
            rentalLabel: " Court Rental ",
            dateValue: 'Mondey ,6Feb ',
            timeValue: "08:00pm",
            rentalValue: " 150 EGP ",
            extraMoney: "Add Equipment",
            extraMoneyvaue: 50,
          ),
        ],
      ),
    );
  }
}
