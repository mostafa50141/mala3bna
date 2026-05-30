import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/games_category.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/list_view_of_coach_category.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/list_view_of_courts_category.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/list_view_of_academic_category.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/user_info_search_field_container.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/popular_sports_grid.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/recent_bookings_section.dart';
import 'package:mala3bna/core/widgets/section_title.dart';
import 'package:mala3bna/features/player/home/presentation/view_model/courts_cubit/courts_cubit.dart';
import 'package:mala3bna/core/widgets/custome_circular_laoding.dart';
import 'package:mala3bna/core/widgets/custome_erorr_widget.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/courts_map_section.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int selectedIndex = 0;
  final List<String> categories = const [
    'All',
    'Football',
    'Tennis',
    'Swimming',
    'Padel',
  ];
  String searchQuery = '';

  // sport filter
  void _onSportSelected(int index) {
    setState(() => selectedIndex = index);
    final sports = ['All', 'Football', 'Tennis', 'Swimming', 'Padel'];
    context.read<CourtsCubit>().filterBySport(sports[index]);
  }

  // search
  void _onSearch(String query) {
    setState(() {
      searchQuery = query;
    });
    context.read<CourtsCubit>().search(query);
  }

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
                  onSearchChanged: _onSearch,
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
                          onSportSelected: (sport) {
                            final index = categories.indexOf(sport);
                            _onSportSelected(index);
                          },
                        ),
                      ),

                      const Gap(16),

                      SectionTitle(title: 'Courts Near You'),
                      const Gap(8),
                      BlocBuilder<CourtsCubit, CourtsState>(
                        builder: (context, state) {
                          if (state is CourtsSuccess) {
                            return CourtsMapSection(courts: state.courts);
                          }
                          return Container(
                            height: 220,
                            decoration: BoxDecoration(
                              color: AppColors.colorBtnAndCard,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: CustomeCircularLaoding(),
                            ),
                          );
                        },
                      ),

                      const Gap(24),

                      SectionTitle(title: 'Nearby Courts'),

                      BlocBuilder<CourtsCubit, CourtsState>(
                        builder: (context, state) {
                          if (state is CourtsLoading) {
                            return const SizedBox(
                              height: 220,
                              child: Center(child: CustomeCircularLaoding()),
                            );
                          } else if (state is CourtsSuccess) {
                            return ListViewOfCourtsCategory(
                              courts: state.courts,
                            );
                          } else if (state is CourtsFailure) {
                            return const SizedBox(
                              height: 220,
                              child: Center(child: CustomeErorrWidget()),
                            );
                          }
                          return const SizedBox.shrink();
                        },
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
