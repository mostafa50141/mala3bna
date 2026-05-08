import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';

class CourtModel extends CourtEntity {
  CourtModel({
    required super.id,
    required super.name,
    required super.location,
    required super.image,
    required super.rating,
  });

  factory CourtModel.fromJson(Map<String, dynamic> json) {
    return CourtModel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      image: json['image'],
      rating: json['rating'].toDouble(),
    );
  }
}
