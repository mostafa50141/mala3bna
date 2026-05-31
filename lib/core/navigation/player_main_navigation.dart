import 'package:flutter/material.dart';
import 'package:mala3bna/core/widgets/custom_bottom_nav.dart';
import 'package:mala3bna/features/player/home/presentation/views/home_view.dart';
import 'package:mala3bna/features/player/map/views/map_view.dart';
import 'package:mala3bna/features/player/profile/views/profile_view.dart';
// Note: You will need to implement MessagesView and place it in the correct location or uncomment/import
// import 'package:mala3bna/features/player/messages/views/messages_view.dart';
// for now, a Placeholder is provided if it does not exist yet.

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
    Center(
      child: Text("Messages", style: TextStyle(color: Colors.white)),
    ), // Placeholder for MessagesView()
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        badges: [0, 0, 5, 0],
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
