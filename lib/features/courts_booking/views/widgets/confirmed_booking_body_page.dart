import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/courts_booking/views/widgets/qr_card.dart';

class ConfirmedBookingBodyPage extends StatelessWidget {
  const ConfirmedBookingBodyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Gap(110),
          Center(
            child: Lottie.asset(
              'assets/animations/Confirm.json',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
              repeat: false,
              reverse: false,
              animate: true,
            ),
          ),
          Gap(30),
          Text(
            "Booking Confirmed!",
            style: Style.textStyleBold26.copyWith(color: Color(0xff91A16C)),
          ),
          Gap(5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Your Court is Ready For Action. See You There!",
              style: Style.textStyle16.copyWith(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ),
          Gap(50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const QrCard(),
          ),
        ],
      ),
    );
  }
}
