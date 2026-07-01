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

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    int? asInt(dynamic value) {
      if (value is int) return value;
      if (value is num) return value.toInt();
      if (value is String) return int.tryParse(value);
      return null;
    }

    double asDouble(dynamic value, {double fallback = 0.0}) {
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? fallback;
      return fallback;
    }

    String asString(dynamic value, {String fallback = ''}) {
      if (value == null) return fallback;
      return value.toString();
    }

    final field = json['field'];
    final fieldData = field is Map<String, dynamic> ? field : null;

    return BookingModel(
      id: asInt(json['booking_id'] ?? json['id']),
      fieldId: asInt(fieldData?['field_id'] ?? fieldData?['id'] ?? field),
      courtName: asString(
        json['field_name'] ?? fieldData?['name'],
        fallback: 'Unknown Court',
      ),
      courtImage: asString(
        json['court_image'] ?? fieldData?['image'],
        fallback: 'assets/images/Court.png',
      ),
      sport: asString(json['sport_type'] ?? fieldData?['sport_type']),
      date: asString(json['booking_date'] ?? json['date']),
      startTime: asString(json['start_time']),
      endTime: asString(json['end_time']),
      duration: asDouble(json['duration'], fallback: 1.0),
      price: asDouble(json['total_price'] ?? json['price']),
      status: asString(json['status'], fallback: 'pending'),
    );
  }

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
