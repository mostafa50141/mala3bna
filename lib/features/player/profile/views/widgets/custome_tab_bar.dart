import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/player/profile/views/widgets/court_card_list_view.dart';

class CustomeTabBar extends StatelessWidget {
  const CustomeTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const [
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
              Tab(text: 'Cancelled'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CourtCardListView(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CourtCardListView(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CourtCardListView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
