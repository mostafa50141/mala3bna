import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mala3bna/features/player/courts_booking/views/court_details.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/games_category.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/list-view-of-coach-category.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/list_view-of-courts-category.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/list_view_of_academic_category.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/user_info_search_field_container.dart';
import 'package:mala3bna/core/widgets/custom_text.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
    required this.selectedIndex,
    required this.category,
  });

  final int selectedIndex;
  final List category;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(15),

                  UserInfoAndSearchFieldContainer(),

                  const Gap(15),

                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: GamesCategory(
                      selectedIndex: selectedIndex,
                      category: category,
                    ),
                  ),

                  const Gap(25),

                  customText(
                    text: 'Nearby Courts',
                    size: 25,
                    weight: FontWeight.bold,
                  ),

                  const Gap(10),

                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => const BookingsView(),
                        transition: Transition.fadeIn,
                        duration: const Duration(milliseconds: 500),
                      );
                    },
                    child: ListViewOfCourtsCategory(),
                  ),

                  const Gap(25),

                  customText(
                    text: 'Featured Coaches',
                    size: 25,
                    weight: FontWeight.bold,
                  ),

                  const Gap(10),

                  ListViewOfCoachCategory(),

                  const Gap(25),

                  customText(
                    text: 'Training Academies',
                    size: 25,
                    weight: FontWeight.bold,
                  ),

                  const Gap(10),

                  ListViewOfAcademicCategory(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
