import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/booking/presentation/cubit/booking_cubit.dart';
import 'package:mala3bna/features/owner/booking/presentation/cubit/booking_state.dart';
import 'package:mala3bna/features/owner/booking/presentation/view/widgets/booking_card.dart';
import 'package:mala3bna/features/owner/booking/presentation/view/widgets/filters_section.dart';

class BookingRequestBody extends StatelessWidget {
  const BookingRequestBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        // Show snackbar feedback after accept/decline completes
      },
      builder: (context, state) {
        if (state is BookingLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }

        if (state is BookingError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_off_rounded,
                    color: Colors.grey[600], size: 52),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style:
                      const TextStyle(color: Colors.grey, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () =>
                      context.read<BookingCubit>().loadBookings(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is BookingLoaded) {
          final bookings = state.filtered;

          return Column(
            children: [
              const SizedBox(height: 8),
              const FiltersSection(),
              const SizedBox(height: 4),

              // Summary chips
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      '${bookings.length} request${bookings.length != 1 ? 's' : ''}',
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: bookings.isEmpty
                    ? _EmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        itemCount: bookings.length,
                        itemBuilder: (context, index) {
                          final booking = bookings[index];
                          return BookingCard(
                            booking: booking,
                            isProcessing: state.processingIds
                                .contains(booking.id),
                          );
                        },
                      ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_rounded,
              color: Colors.grey[700], size: 60),
          const SizedBox(height: 16),
          const Text(
            'No bookings found',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          const Text(
            'Try changing the filter above',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
