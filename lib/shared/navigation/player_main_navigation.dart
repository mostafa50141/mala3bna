import 'package:flutter/material.dart';
import 'package:mala3bna/core/widgets/custom_bottom_nav.dart';
import 'package:mala3bna/features/player/courts_booking/views/court_details.dart';
import 'package:mala3bna/features/player/home/presentation/views/home_view.dart';
import 'package:mala3bna/features/player/messages/views/messages_view.dart';
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
    BookingsView(),
    MessagesView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_score),
            activeIcon: Icon(Icons.sports_score_outlined),
            label: 'Courts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            activeIcon: Icon(Icons.chat),
            label: 'Messages',
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
