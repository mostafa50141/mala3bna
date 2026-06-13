class BookingModel {
  final int? id;
  final int? fieldId;
  final String courtName;
  final String courtLocation;
  final String courtImage;
  final String sport;
  final String date;
  final String time;
  final double price;
  final String status;
  final String? notes;

  const BookingModel({
    this.id,
    this.fieldId,
    required this.courtName,
    required this.courtLocation,
    required this.courtImage,
    required this.sport,
    required this.date,
    required this.time,
    required this.price,
    required this.status,
    this.notes,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    id: json['id'] as int?,
    fieldId: json['field'] as int?,
    courtName: json['field_name'] as String? ?? '',
    courtLocation: '',
    courtImage: 'assets/images/Court.png',
    sport: '',
    date: json['booking_date'] as String? ?? '',
    time: json['start_time'] as String? ?? '',
    price: double.tryParse(
          json['total_price']?.toString() ?? '0',
        )?.toDouble() ?? 0,
    status: json['status'] as String? ?? 'pending',
    notes: json['notes'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'courtName': courtName,
    'courtLocation': courtLocation,
    'courtImage': courtImage,
    'sport': sport,
    'date': date,
    'time': time,
    'price': price,
    'status': status,
  };
}
