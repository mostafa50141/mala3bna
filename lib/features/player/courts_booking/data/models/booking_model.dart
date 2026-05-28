import 'package:flutter/foundation.dart';

class BookingModel {
  final String id;
  final String courtName;
  final String courtLocation;
  final String courtImage;
  final String sport;
  final String date;
  final String time;
  final int price;
  final String status; // 'upcoming', 'past', 'cancelled'

  const BookingModel({
    required this.id,
    required this.courtName,
    required this.courtLocation,
    required this.courtImage,
    required this.sport,
    required this.date,
    required this.time,
    required this.price,
    required this.status,
  });

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

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    id: json['id'],
    courtName: json['courtName'],
    courtLocation: json['courtLocation'],
    courtImage: json['courtImage'],
    sport: json['sport'],
    date: json['date'],
    time: json['time'],
    price: json['price'],
    status: json['status'],
  );
}
