import 'package:mala3bna/features/owner/booking/domain/entities/booking_entity.dart';

class BookingModel {
  final String id;
  final String playerName;
  final String sport;
  final String duration;
  final String dateTime;
  final String price;
  final String avatarUrl;
  final String fieldId;
  final String fieldTitle;
  final String statusString;

  BookingModel({
    required this.id,
    required this.playerName,
    required this.sport,
    required this.duration,
    required this.dateTime,
    required this.price,
    required this.avatarUrl,
    required this.fieldId,
    required this.fieldTitle,
    required this.statusString,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    print('[BookingModel] Parsing JSON keys: ${json.keys.toList()}');
    return BookingModel(
      id: json['booking_id']?.toString() ?? json['id']?.toString() ?? '',
      playerName: json['player_name']?.toString() ?? json['user']?.toString() ?? 'Unknown Player',
      sport: json['sport_type']?.toString() ?? json['sport']?.toString() ?? 'Football',
      duration: json['duration']?.toString() ?? '60',
      dateTime: '${json['booking_date'] ?? ''} ${json['start_time'] ?? ''}'.trim(),
      price: json['total_price']?.toString() ?? json['price']?.toString() ?? '0',
      avatarUrl: json['player_image']?.toString() ?? json['avatar_url']?.toString() ?? '',
      fieldId: json['field']?.toString() ?? json['field_id']?.toString() ?? '',
      fieldTitle: json['field_name']?.toString() ?? json['field_title']?.toString() ?? 'Unknown Field',
      statusString: json['status']?.toString() ?? 'pending',
    );
  }

  BookingStatus _statusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
      case 'accepted':
        return BookingStatus.approved;
      case 'declined':
      case 'rejected':
        return BookingStatus.declined;
      case 'pending':
      default:
        return BookingStatus.pending;
    }
  }

  BookingEntity toEntity() {
    return BookingEntity(
      id: id,
      playerName: playerName,
      sport: sport,
      duration: duration,
      dateTime: dateTime,
      price: price,
      avatarUrl: avatarUrl,
      fieldId: fieldId,
      fieldTitle: fieldTitle,
      status: _statusFromString(statusString),
    );
  }
}
