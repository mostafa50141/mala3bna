import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeSlot {
  static List<String> generateTimeSlots({
    required TimeOfDay start,
    required TimeOfDay end,
    required int intervalMinutes,
  }) {
    List<String> slots = [];
    DateTime now = DateTime.now();

    DateTime startTime = DateTime(
      now.year,
      now.month,
      now.day,
      start.hour,
      start.minute,
    );
    DateTime endTime = DateTime(
      now.year,
      now.month,
      now.day,
      end.hour,
      end.minute,
    );
    if (endTime.isBefore(startTime)) {
      endTime = endTime.add(Duration(days: 1));
    }
    final formatter = DateFormat('h:mm a');

    while (startTime.isBefore(endTime) || startTime.isAtSameMomentAs(endTime)) {
      slots.add(formatter.format(startTime));
      startTime = startTime.add(Duration(minutes: intervalMinutes));
    }
    return slots;
  }
}
