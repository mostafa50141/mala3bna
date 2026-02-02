import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/courts_booking/views/court_booking_summry.dart';
import 'package:mala3bna/features/courts_booking/views/widgets/amenities_item_builder.dart';
import 'package:mala3bna/features/courts_booking/views/widgets/chip_chioce_time.dart';
import 'package:mala3bna/features/courts_booking/views/widgets/custom_app_bar_court.dart';
import 'package:mala3bna/features/courts_booking/views/widgets/custom_carousel_slider.dart';
import 'package:mala3bna/features/courts_booking/views/widgets/custom_container.dart';
import 'package:mala3bna/features/courts_booking/views/widgets/table_calendar.dart';
import 'package:mala3bna/shared/widgets/custom_btn.dart';

class CourtDetailsBody extends StatelessWidget {
  const CourtDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: const CustomCarouselSlider(),
              expandedHeight: 250,
              title: const CustomAppBarCourt(title: "Court Details"),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("Sky Padel - Court1", style: Style.textStyle26),
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        CustomContainer(
                          height: 40,
                          text1: "Sports Type: ",
                          text2: "Padel",
                        ),
                        Gap(10),
                        CustomContainer(
                          height: 40,
                          text1: "Ratig: ",
                          text2: "4.5 Stars",
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text("Amenities", style: Style.textStyle20Bold),
                  ),
                  const Gap(10),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: 90,
                  child: const AmenitiesItemBuilder(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF2B3A41),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Gap(10),
                      Text('Price: ', style: Style.textStyle16Bold),
                      Spacer(),
                      Text(
                        '\$150/hour',
                        style: Style.textStyle16Bold.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Gap(20),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(' Select Date and Time', style: Style.textStyle20Bold),
                    const Gap(10),
                    CustomTableCalendar(),
                    const Gap(20),
                    CustomeChoiceChipTime(),
                    const Gap(30),
                    Center(
                      child: CustomBtn(
                        text: ' Book Now ',
                        height: 50,
                        width: 350,
                        radius: 25,
                        weightText: FontWeight.bold,
                        sizeText: 18,
                        onTap: () {
                          Get.to(() => const CourtBookingSummry());
                        },
                      ),
                    ),
                    const Gap(30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
