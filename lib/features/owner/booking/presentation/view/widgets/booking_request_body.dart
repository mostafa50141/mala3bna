import 'package:flutter/material.dart';
import 'package:mala3bna/features/owner/booking/presentation/model/booking_request_model.dart';
import 'package:mala3bna/features/owner/booking/presentation/view/widgets/booking_card.dart';
import 'package:mala3bna/features/owner/booking/presentation/view/widgets/filters_section.dart';

class BookingRequestBody extends StatelessWidget {
  const BookingRequestBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bookings = List.generate(
      10,
      (index) => BookingRequest(
        name: index % 2 == 0 ? "Karim Adel" : "Youssef El-Masry",
        sport: index % 2 == 0 ? "Padel" : "Football",
        duration: index % 2 == 0 ? "1.5 Hours" : "2 Hours",
        dateTime: index % 2 == 0 ? "Today, 06:00 PM" : "Tomorrow, 08:00 PM",
        status: index == 2 ? BookingStatus.approved : BookingStatus.pending,
        avatar: "https://i.pravatar.cc/150?img=$index",
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 4),
          const FiltersSection(),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return BookingCard(booking: bookings[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
