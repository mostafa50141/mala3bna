import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/courts_booking/data/models/booking_model.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:mala3bna/core/widgets/custom_animateds_snack_bar.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback onBookingCancelled;

  const BookingCard({
    super.key,
    required this.booking,
    required this.onBookingCancelled,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.colorBtnAndCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                booking.courtImage,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: AppColors.colorBtnAndCard,
                  child: const Icon(Icons.sports_soccer, color: Colors.grey),
                ),
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.courtName,
                    style: Style.textStyle14Bold.copyWith(color: Colors.white),
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 12,
                        color: Colors.grey,
                      ),
                      const Gap(4),
                      Text(
                        booking.date,
                        style: Style.textStyle12.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 12,
                        color: Colors.grey,
                      ),
                      const Gap(4),
                      Text(
                        booking.time,
                        style: Style.textStyle12.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 12,
                        color: AppColors.primaryColor,
                      ),
                      const Gap(4),
                      Expanded(
                        child: Text(
                          booking.courtLocation,
                          style: Style.textStyle12.copyWith(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Text(
                    '${booking.price} EGP',
                    style: Style.textStyle14Bold.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            if (booking.status == 'upcoming')
              OutlinedButton(
                onPressed: () async {
                  await getIt.get<LocalStorageHelper>().cancelBooking(
                    booking.id,
                  );
                  onBookingCancelled();
                  if (context.mounted) {
                    showAnimatedSnackDialog(
                      context,
                      message: "Booking cancelled",
                      type: AnimatedSnackBarType.success,
                    );
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Cancel',
                  style: Style.textStyle12.copyWith(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
