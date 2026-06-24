import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/core/widgets/custom_bottom_nav.dart';
import 'package:mala3bna/features/owner/booking/presentation/view/booking_request_view.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/court_profile_cubit.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/court_profile_view.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/owner_dashboard_view.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/owner_settings_view.dart';

class OwnerMainNavigation extends StatefulWidget {
  const OwnerMainNavigation({super.key});

  @override
  State<OwnerMainNavigation> createState() => _OwnerMainNavigationState();
}

class _OwnerMainNavigationState extends State<OwnerMainNavigation> {
  int _currentIndex = 0;

  /// A cubit shared between the navigation shell and the Courts tab so we can
  /// trigger a reload when the owner adds their first court.
  late final CourtProfileCubit _courtProfileCubit;

  @override
  void initState() {
    super.initState();
    _courtProfileCubit = CourtProfileCubit(getIt<CourtRepository>())
      ..loadCourtProfile();
  }

  @override
  void dispose() {
    _courtProfileCubit.close();
    super.dispose();
  }

  /// Called by OwnerDashboardBody after the first court is added successfully.
  void _onCourtAdded() {
    // Switch to Courts tab
    setState(() => _currentIndex = 2);
    // Reload the court profile so it shows the newly added court's data
    _courtProfileCubit.loadCourtProfile();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      OwnerDashboardView(onCourtAdded: _onCourtAdded),
      const BookingRequestView(),
      BlocProvider.value(
        value: _courtProfileCubit,
        child: const CourtProfileView(fromNavigation: true),
      ),
      const OwnerSettingsView(),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
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
