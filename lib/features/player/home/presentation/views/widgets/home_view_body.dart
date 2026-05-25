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
    required this.searchQuery,
    this.onCategoryChanged,
    this.onSearchChanged,
  });

  final int selectedIndex;
  final List<String> categories;
  final String searchQuery;
  final Function(int)? onCategoryChanged;
  final Function(String)? onSearchChanged;

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
                child: UserInfoAndSearchFieldContainer(
                  onSearchChanged: onSearchChanged,
                ),
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
                          onCategorySelected: onCategoryChanged,
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
                        child: ListViewOfCourtsCategory(
                          selectedSport: selectedIndex,
                          searchQuery: searchQuery,
                        ),
                      ),

                      const Gap(25),

                      SectionTitle(title: 'Popular Sports'),
                      const PopularSportsGrid(),

                      const Gap(25),

                      SectionTitle(title: 'Recent Bookings'),
                      const RecentBookingsSection(),

                      const Gap(25),

                      SectionTitle(title: 'Featured Coaches'),
                      ListViewOfCoachCategory(
                        selectedSport: selectedIndex,
                        searchQuery: searchQuery,
                      ),

                      const Gap(25),

                      SectionTitle(title: 'Training Academies'),
                      ListViewOfAcademicCategory(
                        selectedSport: selectedIndex,
                        searchQuery: searchQuery,
                      ),

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
