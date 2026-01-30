import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/features/courts/views/widgets/custom_app_bar_court.dart';
import 'package:mala3bna/features/courts/views/widgets/custom_carousel_slider.dart';

class CourtDetailsBody extends StatelessWidget {
  const CourtDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarCourt(title: 'Court Details'),
          const Gap(20),
          CustomCarouselSlider(),

          // Add more widgets here for court details
        ],
      ),
    );
  }
}
