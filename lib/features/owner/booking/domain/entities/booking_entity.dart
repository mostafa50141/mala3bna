import 'package:equatable/equatable.dart';

enum BookingStatus { pending, approved, declined }

class BookingEntity extends Equatable {
  final String id;
  final String playerName;
  final String sport;
  final String duration;
  final String dateTime;
  final String price;
  final String avatarUrl;
  final String fieldId;
  final String fieldTitle;
  final BookingStatus status;

  const BookingEntity({
    required this.id,
    required this.playerName,
    required this.sport,
    required this.duration,
    required this.dateTime,
    required this.price,
    required this.avatarUrl,
    required this.fieldId,
    required this.fieldTitle,
    required this.status,
  });

  BookingEntity copyWith({
    String? id,
    String? playerName,
    String? sport,
    String? duration,
    String? dateTime,
    String? price,
    String? avatarUrl,
    String? fieldId,
    String? fieldTitle,
    BookingStatus? status,
  }) {
    return BookingEntity(
      id: id ?? this.id,
      playerName: playerName ?? this.playerName,
      sport: sport ?? this.sport,
      duration: duration ?? this.duration,
      dateTime: dateTime ?? this.dateTime,
      price: price ?? this.price,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      fieldId: fieldId ?? this.fieldId,
      fieldTitle: fieldTitle ?? this.fieldTitle,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        id,
        playerName,
        sport,
        duration,
        dateTime,
        price,
        avatarUrl,
        fieldId,
        fieldTitle,
        status,
      ];
}
