import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/widgets/custome_circular_laoding.dart';
import 'package:mala3bna/features/player/courts_booking/presentation/cubit/booking_cubit.dart';
import 'package:mala3bna/features/player/courts_booking/presentation/cubit/booking_state.dart';
import 'package:mala3bna/features/player/profile/views/widgets/booking_list_view.dart';

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
            child: BlocBuilder<BookingCubit, BookingState>(
              builder: (context, state) {
                if (state is BookingLoading) {
                  return const Center(child: CustomeCircularLaoding());
                }

                if (state is BookingFailure) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                }

                if (state is BookingCancelled) {
                  // Rebuild will come from getBookings() triggered inside cubit
                  return const Center(child: CustomeCircularLaoding());
                }

                if (state is BookingsLoaded) {
                  final upcoming = state.bookings
                      .where((b) => b.status == 'pending')
                      .toList();
                  final confirmed = state.bookings
                      .where((b) => b.status == 'confirmed')
                      .toList();
                  final cancelled = state.bookings
                      .where((b) => b.status == 'cancelled')
                      .toList();

                  return TabBarView(
                    children: [
                      BookingListView(bookings: upcoming, showCancel: true),
                      BookingListView(bookings: confirmed, showCancel: false),
                      BookingListView(bookings: cancelled, showCancel: false),
                    ],
                  );
                }

                // BookingInitial / fallback
                return const Center(
                  child: Text(
                    'No bookings yet',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
