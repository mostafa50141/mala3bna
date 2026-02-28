import 'package:flutter/material.dart';
import 'package:mala3bna/core/widgets/custom_bottom_nav.dart';
import 'package:mala3bna/features/coach/coachDashboard/presentation/view/coach_dashboard_view.dart';
import 'package:mala3bna/features/coach/messages/presentation/views/coach_messages_view.dart';
import 'package:mala3bna/features/coach/profile/presentation/views/coach_profile_view.dart';
import 'package:mala3bna/features/coach/schedule/presentation/views/coach_schedule_view.dart';

class CoachMainNavigation extends StatefulWidget {
  const CoachMainNavigation({super.key});

  @override
  State<CoachMainNavigation> createState() => _CoachMainNavigationState();
}

class _CoachMainNavigationState extends State<CoachMainNavigation> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    CoachDashboardView(),
    CoachScheduleView(),
    CoachMessagesView(),
    CoachProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        badges: [0, 1, 4, 0],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            activeIcon: Icon(Icons.message),
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
