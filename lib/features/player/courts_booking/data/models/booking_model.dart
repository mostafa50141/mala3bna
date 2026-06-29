class BookingModel {
  final int? id;
  final int? fieldId;
  final String courtName;
  final String courtImage;
  final String sport;
  final String date;
  final String startTime;
  final String endTime;
  final double duration;
  final double price;
  final String status;

  const BookingModel({
    this.id,
    this.fieldId,
    required this.courtName,
    required this.courtImage,
    required this.sport,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.price,
    required this.status,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json['booking_id'] as int?,
        fieldId: json['field'] as int?,
        courtName: json['field_name'] as String? ?? 'Unknown Court',
        courtImage: 'assets/images/Court.png',
        sport: json['sport_type'] as String? ?? '',
        date: json['booking_date'] as String? ?? '',
        startTime: json['start_time'] as String? ?? '',
        endTime: json['end_time'] as String? ?? '',
        duration: (json['duration'] as num?)?.toDouble() ?? 1.0,
        price: double.tryParse(
              json['total_price']?.toString() ?? '0',
            ) ??
            0.0,
        status: json['status'] as String? ?? 'pending',
      );

  Map<String, dynamic> toJson() => {
        'booking_id': id,
        'field': fieldId,
        'field_name': courtName,
        'court_image': courtImage,
        'sport_type': sport,
        'booking_date': date,
        'start_time': startTime,
        'end_time': endTime,
        'duration': duration,
        'total_price': price.toString(),
        'status': status,
      };

  // Display helpers
  String get timeDisplay {
    String fmt(String t) {
      try {
        final p = t.split(':');
        int h = int.parse(p[0]);
        final m = p[1];
        final period = h >= 12 ? 'PM' : 'AM';
        if (h > 12) h -= 12;
        if (h == 0) h = 12;
        return '$h:$m $period';
      } catch (_) {
        return t;
      }
    }

    return '${fmt(startTime)} - ${fmt(endTime)}';
  }

  String get priceDisplay => '${price.toInt()} EGP';
}
