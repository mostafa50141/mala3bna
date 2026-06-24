import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/owner/booking/domain/repositories/booking_repository.dart';
import 'package:mala3bna/features/owner/booking/presentation/cubit/booking_cubit.dart';
import 'package:mala3bna/features/owner/booking/presentation/cubit/booking_state.dart';
import 'package:mala3bna/features/owner/booking/presentation/view/widgets/booking_request_body.dart';

class BookingRequestView extends StatelessWidget {
  const BookingRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingCubit(getIt<BookingRepository>())..loadBookings(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          children: [
            _BookingHeader(),
            const Expanded(child: BookingRequestBody()),
          ],
        ),
      ),
    );
  }
}

class _BookingHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: AppColors.primaryColor.withOpacity(0.15),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Booking Requests',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              // Live pending badge
              BlocBuilder<BookingCubit, BookingState>(
                builder: (context, state) {
                  if (state is! BookingLoaded || state.pendingCount == 0) {
                    return const SizedBox.shrink();
                  }
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.orange.withOpacity(0.5), width: 1),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${state.pendingCount} Pending',
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
