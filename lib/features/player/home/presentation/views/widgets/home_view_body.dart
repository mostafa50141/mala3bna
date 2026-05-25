import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mala3bna/features/player/courts_booking/views/court_details.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/games_category.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/list_view_of_coach_category.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/list_view_of_courts_category.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/list_view_of_academic_category.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/user_info_search_field_container.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/popular_sports_grid.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/recent_bookings_section.dart';
import 'package:mala3bna/core/widgets/section_title.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
    required this.selectedIndex,
    required this.categories,
  });

  final int selectedIndex;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: UserInfoAndSearchFieldContainer(),
              ),

              const SliverToBoxAdapter(child: Gap(20)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: GamesCategory(
                          selectedIndex: selectedIndex,
                          categories: categories,
                        ),
                      ),

                      const Gap(25),

                      SectionTitle(title: 'Nearby Courts'),

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

                      SectionTitle(title: 'Popular Sports'),
                      const PopularSportsGrid(),

                      const Gap(25),

                      SectionTitle(title: 'Recent Bookings'),
                      const RecentBookingsSection(),

                      const Gap(25),

                      SectionTitle(title: 'Featured Coaches'),
                      ListViewOfCoachCategory(),

                      const Gap(25),

                      SectionTitle(title: 'Training Academies'),
                      ListViewOfAcademicCategory(),

                      const Gap(20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
