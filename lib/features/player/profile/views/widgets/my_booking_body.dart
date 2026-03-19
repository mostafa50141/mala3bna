import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/features/player/profile/views/widgets/custome_app_bar.dart';
import 'package:mala3bna/features/player/profile/views/widgets/custome_tab_bar.dart';

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
          const Gap(32),

          Expanded(child: CustomeTabBar()),
          // Expanded(child: CourtCardListView()),
          const Gap(24),
        ],
      ),
    );
  }
}
