import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';
import 'package:mala3bna/features/player/courts_booking/views/court_booking_summry.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/amenities_item_builder.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/chip_chioce_time.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/custom_app_bar_court.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/custom_carousel_slider.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/custom_container.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/table_calendar.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';

class CourtDetailsBody extends StatefulWidget {
  final CourtModel court;

  const CourtDetailsBody({
    super.key,
    required this.court,
  });

  @override
  State<CourtDetailsBody> createState() => _CourtDetailsBodyState();
}

class _CourtDetailsBodyState extends State<CourtDetailsBody> {
  DateTime _selectedDay = DateTime.now();
  String selectedOption = "4:00 PM";

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
              flexibleSpace: CustomCarouselSlider(imageUrl: widget.court.imageUrl),
              expandedHeight: 220,
              title: const CustomAppBarCourt(title: "Court Details"),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.court.name,
                      style: Style.textStyle26.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.grey, size: 16),
                        const Gap(4),
                        Text(
                          widget.court.location,
                          style: Style.textStyle14.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const Gap(8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomContainer(
                            height: 40,
                            text1: "Sport Type:",
                            text2: widget.court.sport,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: CustomContainer(
                            height: 40,
                            text1: "Rating: ",
                            text2: "${widget.court.rating} Stars",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text("Amenities", style: Style.textStyle18Bold),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: const AmenitiesItemBuilder(),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B3A41),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Gap(20),
                      Text('Price', style: Style.textStyle16Bold),
                      const Spacer(),
                      Text(
                        '${widget.court.pricePerHour} EGP/ hr',
                        style: Style.textStyle20.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const Gap(20),
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
                    const Gap(10),
                    Text(' Select Date & Time', style: Style.textStyle18Bold),
                    const Gap(10),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2B3A41),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CustomTableCalendar(
                        onDateSelected: (date) {
                          setState(() {
                            _selectedDay = date;
                          });
                        },
                      ),
                    ),
                    const Gap(20),
                    CustomeChoiceChipTime(
                      onTimeSelected: (time) {
                        setState(() {
                          selectedOption = time;
                        });
                      },
                    ),
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
                          Get.to(() => CourtBookingSummry(
                                court: widget.court,
                                selectedDate: _selectedDay,
                                selectedTime: selectedOption,
                              ));
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
