import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/features/player/profile/views/widgets/court_card_list_view.dart';
// import 'package:mala3bna/core/utils/assets_data.dart';
import 'package:mala3bna/features/player/profile/views/widgets/custome_app_bar.dart';

class MyBookingBody extends StatelessWidget {
  const MyBookingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48, left: 8, right: 8),
      child: Column(
        children: [
          CustomeAppBar(
            title: "My Bookings",
            leadingIcon: Icon(Icons.arrow_back),
            onPressedLeadingIcon: () {},
            onPressedTrailingIcon: () {},
            trailainIcone: Icon(Icons.more_vert),
          ),
          const Gap(24),
          Expanded(child: CourtCardListView()),
          // Image.asset("assets/images/Football court.png", fit: BoxFit.cover),
          const Gap(24),
        ],
      ),
    );
  }
}
