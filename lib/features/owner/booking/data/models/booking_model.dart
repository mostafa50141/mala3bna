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

    String extractName() {
      if (json['player_name'] != null && json['player_name'] != '') return json['player_name'].toString();
      if (json['user_name'] != null && json['user_name'] != '') return json['user_name'].toString();
      if (json['user'] is Map) {
        final user = json['user'];
        final name = '${user['first_name'] ?? ''} ${user['last_name'] ?? ''}'.trim();
        if (name.isNotEmpty) return name;
        if (user['name'] != null) return user['name'].toString();
      }
      if (json['player'] is Map) {
        final player = json['player'];
        final name = '${player['first_name'] ?? ''} ${player['last_name'] ?? ''}'.trim();
        if (name.isNotEmpty) return name;
        if (player['name'] != null) return player['name'].toString();
      }
      if (json['user'] is String) return json['user'].toString();
      return 'Unknown Player';
    }

    String extractImage() {
      if (json['player_image'] != null && json['player_image'] != '') return json['player_image'].toString();
      if (json['user_image'] != null && json['user_image'] != '') return json['user_image'].toString();
      if (json['avatar_url'] != null && json['avatar_url'] != '') return json['avatar_url'].toString();
      if (json['user'] is Map) {
        if (json['user']['image'] != null) return json['user']['image'].toString();
        if (json['user']['avatar'] != null) return json['user']['avatar'].toString();
        if (json['user']['profile_image'] != null) return json['user']['profile_image'].toString();
      }
      if (json['player'] is Map) {
        if (json['player']['image'] != null) return json['player']['image'].toString();
        if (json['player']['avatar'] != null) return json['player']['avatar'].toString();
      }
      return '';
    }

    return BookingModel(
      id: json['booking_id']?.toString() ?? json['id']?.toString() ?? '',
      playerName: extractName(),
      sport: json['sport_type']?.toString() ?? json['sport']?.toString() ?? 'Football',
      duration: json['duration']?.toString() ?? '60',
      dateTime: '${json['booking_date'] ?? ''} ${json['start_time'] ?? ''}'.trim(),
      price: json['total_price']?.toString() ?? json['price']?.toString() ?? '0',
      avatarUrl: extractImage(),
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
