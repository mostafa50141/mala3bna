import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/player/courts_booking/data/repos/booking_repo.dart';
import 'package:mala3bna/features/player/courts_booking/presentation/cubit/booking_cubit.dart';
import 'package:mala3bna/features/player/profile/views/widgets/custome_tab_bar.dart';

class MyBookingsViews extends StatelessWidget {
  const MyBookingsViews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookingCubit(getIt.get<BookingRepo>())..getBookings(),
      child: const MyBookingsBody(),
    );
  }
}

class MyBookingsBody extends StatelessWidget {
  const MyBookingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'My Bookings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: const CustomeTabBar(),
    );
  }
}
