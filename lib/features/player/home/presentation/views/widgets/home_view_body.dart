import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/widgets/custom_circular_loading.dart';
import 'package:mala3bna/core/widgets/custom_error_widget.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/games_category.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/list_view_of_courts_category.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/user_info_search_field_container.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/popular_sports_grid.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/recent_bookings_section.dart';
import 'package:mala3bna/core/widgets/section_title.dart';
import 'package:mala3bna/features/player/home/presentation/view_model/courts_cubit/courts_cubit.dart';
import 'package:mala3bna/core/utils/location_service.dart';
import 'package:mala3bna/core/utils/service_locator.dart';

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

  @override
  void initState() {
    super.initState();
    _sortCourtsByLocation();
  }

  Future<void> _sortCourtsByLocation() async {
    final result = await getIt.get<LocationService>().getUserLocation();
    if (result.isSuccess && mounted) {
      context.read<CourtsCubit>().sortByDistance(
        result.location!.latitude,
        result.location!.longitude,
      );
    }
  }

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
                          } else if (state is CourtsEmpty) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(24),
                                child: Text(
                                  'No courts found',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
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
                      
                      // Coming Soon Widget
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryColor.withOpacity(0.8),
                              AppColors.fieldBackground.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primaryColor.withOpacity(0.3),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.rocket_launch_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const Gap(16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Coming Soon!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Gap(6),
                                  Text(
                                    'Coaches & Academies features are on the way. Stay tuned!',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 14,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
