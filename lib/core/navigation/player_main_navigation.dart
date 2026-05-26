import 'package:flutter/material.dart';
import 'package:mala3bna/core/widgets/custom_bottom_nav.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';
import 'package:mala3bna/features/player/courts_booking/views/court_details.dart';
import 'package:mala3bna/features/player/home/presentation/views/home_view.dart';
import 'package:mala3bna/features/player/maps/views/maps_view.dart';
import 'package:mala3bna/features/player/profile/views/profile_view.dart';

class PlayerMainNavigation extends StatefulWidget {
  const PlayerMainNavigation({super.key});

  @override
  State<PlayerMainNavigation> createState() => _PlayerMainNavigationState();
}

class _PlayerMainNavigationState extends State<PlayerMainNavigation> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeView(),
    BookingsView(
      courtModel: CourtModel(
        id: 1,
        name: 'Smash Padel Club',
        sport: 'Padel',
        location: 'Zamalek, Cairo',
        rating: 4.9,
        pricePerHour: 350,
        distance: '2.5 km',
        imageUrl: 'assets/images/Court.png',
      ),
    ),
    MapsView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        badges: [0, 2, 5, 0],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_score_outlined),
            activeIcon: Icon(Icons.sports_score),
            label: 'Courts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            activeIcon: Icon(Icons.location_on),
            label: 'Maps',
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
