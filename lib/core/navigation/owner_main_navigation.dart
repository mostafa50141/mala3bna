import 'package:flutter/material.dart';
import 'package:mala3bna/core/widgets/custom_bottom_nav.dart';
import 'package:mala3bna/features/owner/booking/presentation/view/booking_request_view.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/my_court_view.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/owner_dashboard_view.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/owner_settings_view.dart';

class OwnerMainNavigation extends StatefulWidget {
  const OwnerMainNavigation({super.key});

  @override
  State<OwnerMainNavigation> createState() => _OwnerMainNavigationState();
}

class _OwnerMainNavigationState extends State<OwnerMainNavigation> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    OwnerDashboardView(),
    BookingRequestView(),
    MyCourtView(),
    OwnerSettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        badges: [0, 3, 0, 0],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stadium_outlined),
            activeIcon: Icon(Icons.stadium),
            label: 'Courts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
