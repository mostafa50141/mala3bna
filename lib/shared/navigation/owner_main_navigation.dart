import 'package:flutter/material.dart';
import 'package:mala3bna/core/widgets/custom_bottom_nav.dart';
import 'package:mala3bna/features/owner/booking/presentation/view/booking_request_view.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/my_court_view.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/owner_dashboard_view.dart';
import 'package:mala3bna/features/owner/profile/presentation/view/owner_profile_view.dart';

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
    OwnerProfileView(),
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
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
