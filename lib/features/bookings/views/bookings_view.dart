import 'package:flutter/material.dart';
import 'package:mala3bna/shared/custom_text.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(child: customText(text: 'Bookings screen', size: 30)),
    );
  }
}
