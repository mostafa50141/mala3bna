import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/courts_booking/data/models/booking_model.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/navigation_button_card.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/qr_card.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';
import 'package:mala3bna/core/navigation/player_main_navigation.dart';
import 'package:mala3bna/features/player/courts_booking/views/directions_screen.dart';

class ConfirmedBookingBodyPage extends StatefulWidget {
  final CourtModel court;
  final DateTime? selectedDate;
  final String? selectedTime;
  final int? bookingId;

  const ConfirmedBookingBodyPage({
    super.key,
    required this.court,
    this.selectedDate,
    this.selectedTime,
    this.bookingId,
  });

  @override
  State<ConfirmedBookingBodyPage> createState() =>
      _ConfirmedBookingBodyPageState();
}

class _ConfirmedBookingBodyPageState extends State<ConfirmedBookingBodyPage> {
  bool _bookingSaved = false;

  @override
  void initState() {
    super.initState();
    if (!_bookingSaved) {
      _bookingSaved = true;
      _saveBooking();
    }
  }

  Future<void> _saveBooking() async {
    // Parse selectedTime to derive startTime/endTime strings
    final startTime = widget.selectedTime ?? '00:00';
    final parsedStartTime = DateFormat('h:mm a').tryParse(startTime);
    final startHour = parsedStartTime?.hour ?? 0;
    final startMinute = parsedStartTime?.minute ?? 0;
    final endTime =
        '${((startHour + 1) % 24).toString().padLeft(2, '0')}:${startMinute.toString().padLeft(2, '0')}:00';
    final startTimeFmt =
        '${startHour.toString().padLeft(2, '0')}:${startMinute.toString().padLeft(2, '0')}:00';

    final booking = BookingModel(
      id: widget.bookingId,
      fieldId: widget.court.id,
      courtName: widget.court.name,
      courtImage: widget.court.imageUrl,
      sport: widget.court.sport,
      date: widget.selectedDate != null
          ? DateFormat('yyyy-MM-dd').format(widget.selectedDate!)
          : '',
      startTime: startTimeFmt,
      endTime: endTime,
      duration: 1.0,
      price: widget.court.pricePerHour,
      status: 'pending',
    );
    await getIt.get<LocalStorageHelper>().saveBooking(booking);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Gap(70),
          Center(
            child: Lottie.asset(
              'assets/animations/Success.json',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
              reverse: false,
              animate: true,
              repeat: true,
            ),
          ),
          Gap(30),
          Text(
            "Booking Confirmed!",
            style: Style.textStyleBold26.copyWith(color: Color(0xff91A16C)),
          ),
          Gap(5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Your Court is Ready For Action. See You There!",
              style: Style.textStyle16.copyWith(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ),
          Gap(85),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: QrCard(
              courtName: widget.court.name,
              location: widget.court.location,
              selectedDate: widget.selectedDate,
              selectedTime: widget.selectedTime,
            ),
          ),
          Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavigationButtonCard(
                  title: "Directions",
                  icon: Icons.directions,
                  onPressed: () {
                    Get.to(() => DirectionsScreen(court: widget.court));
                  },
                ),
                NavigationButtonCard(
                  title: "Contact Owner",
                  icon: Icons.phone,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavigationButtonCard(
                  title: "Add to Calendar",
                  icon: Icons.calendar_today_outlined,
                  onPressed: () {},
                ),
                NavigationButtonCard(
                  title: "Home",
                  icon: Icons.home,
                  onPressed: () {
                    Get.offAll(() => const PlayerMainNavigation());
                  },
                ),
              ],
            ),
          ),
          Gap(50),
        ],
      ),
    );
  }
}
