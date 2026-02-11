import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/courts_booking/views/confirmed_booking_page.dart';
import 'package:mala3bna/features/courts_booking/views/widgets/booking_summary_card.dart';
import 'package:mala3bna/features/courts_booking/views/widgets/custom_app_bar_court.dart';
import 'package:mala3bna/features/courts_booking/views/widgets/payment_card.dart';
import 'package:mala3bna/shared/widgets/custom_btn.dart';

class CourtBookingSummryBody extends StatelessWidget {
  const CourtBookingSummryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBarCourt(title: "Booking Summary"),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BookingSummaryCard(
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
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text("Payment Method", style: Style.textStyle20Bold),
            ),
            const Gap(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PaymentCard(),
            ),
            const Gap(90),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Divider(),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Price", style: Style.textStyle16Bold),
                      Text(
                        "200 EGP",
                        style: Style.textStyle20Bold.copyWith(
                          color: Color(0xff91A16C),
                        ),
                      ),
                    ],
                  ),
                  const Gap(30),
                  Center(
                    child: CustomBtn(
                      text: ' Confirm Booking',
                      height: 50,
                      width: 350,
                      radius: 25,
                      weightText: FontWeight.bold,
                      sizeText: 18,
                      onTap: () {
                        Get.to(() => const ConfirmedBookingPage());
                      },
                    ),
                  ),
                  const Gap(30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
