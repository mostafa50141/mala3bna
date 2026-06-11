import 'package:flutter/material.dart';
import 'package:mala3bna/core/widgets/custom_bottom_nav.dart';
import 'package:mala3bna/features/player/home/presentation/views/home_view.dart';
import 'package:mala3bna/features/player/map/views/map_view.dart';
import 'package:mala3bna/features/player/profile/views/profile_view.dart';
import 'package:mala3bna/features/player/profile/views/my_bookings_views.dart';

class PlayerMainNavigation extends StatefulWidget {
  const PlayerMainNavigation({super.key});

  @override
  State<PlayerMainNavigation> createState() => _PlayerMainNavigationState();
}

class _PlayerMainNavigationState extends State<PlayerMainNavigation> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeView(),
    MapView(),
    MyBookingsViews(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        badges: [0, 0, 0, 0],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
