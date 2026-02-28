import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/owner/booking/presentation/view/widgets/booking_request_body.dart';

class BookingRequestView extends StatelessWidget {
  const BookingRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Booking Requests")),
        backgroundColor: AppColors.backgroundColor,
        scrolledUnderElevation: 0,
        titleTextStyle: Style.textStyle20Bold,
        automaticallyImplyLeading: false,
      ),
      body: BookingRequestBody(),
    );
  }
}
