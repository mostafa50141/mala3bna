import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/core/widgets/custome_circular_laoding.dart';
import 'package:mala3bna/features/player/courts_booking/data/models/booking_model.dart';
import 'package:mala3bna/features/player/profile/views/widgets/booking_list_view.dart';
import 'package:mala3bna/features/player/courts_booking/data/repos/booking_repo.dart';
import 'package:mala3bna/features/player/courts_booking/presentation/cubit/booking_cubit.dart';

class CustomeTabBar extends StatefulWidget {
  const CustomeTabBar({super.key});

  @override
  State<CustomeTabBar> createState() => _CustomeTabBarState();
}

class _CustomeTabBarState extends State<CustomeTabBar> {
  List<BookingModel> _upcomingBookings = [];
  List<BookingModel> _pastBookings = [];
  List<BookingModel> _cancelledBookings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    final cubit = BookingCubit(getIt.get<BookingRepo>());
    final result = await cubit.bookingRepo.getBookings();
    result.fold(
      (failure) => setState(() => _isLoading = false),
      (bookings) {
        setState(() {
          _upcomingBookings = bookings
              .where((b) => b.status == 'pending' || b.status == 'confirmed')
              .toList();
          _pastBookings = bookings
              .where((b) => b.status == 'confirmed' &&
                  DateTime.tryParse(b.date)?.isBefore(DateTime.now()) == true)
              .toList();
          _cancelledBookings = bookings
              .where((b) => b.status == 'cancelled')
              .toList();
          _isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CustomeCircularLaoding());
    }

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
                  child: BookingListView(
                    bookings: _upcomingBookings,
                    onBookingCancelled: _loadBookings,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: BookingListView(
                    bookings: _pastBookings,
                    onBookingCancelled: _loadBookings,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: BookingListView(
                    bookings: _cancelledBookings,
                    onBookingCancelled: _loadBookings,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
