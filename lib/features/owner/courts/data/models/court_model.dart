import 'package:equatable/equatable.dart';
import 'amenity_model.dart';
import 'court_image_model.dart';

class CourtModel extends Equatable {
  final String id;
  final String title;
  final double hourlyRate;
  final List<CourtImageModel> images;
  final List<AmenityModel> amenities;
  final double? lat;
  final double? lng;

  const CourtModel({
    required this.id,
    required this.title,
    required this.hourlyRate,
    required this.images,
    required this.amenities,
    this.lat,
    this.lng,
  });

  CourtModel copyWith({
    String? id,
    String? title,
    double? hourlyRate,
    List<CourtImageModel>? images,
    List<AmenityModel>? amenities,
    double? lat,
    double? lng,
  }) {
    return CourtModel(
      id: id ?? this.id,
      title: title ?? this.title,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      images: images ?? this.images,
      amenities: amenities ?? this.amenities,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  factory CourtModel.fromJson(Map<String, dynamic> json) {
    final imagesJson = (json['images'] as List<dynamic>?) ?? [];
    final amenitiesJson = (json['amenities'] as List<dynamic>?) ?? [];

    return CourtModel(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      hourlyRate: (json['hourlyRate'] as num?)?.toDouble() ?? 0.0,
      images: imagesJson
          .map((e) => CourtImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      amenities: amenitiesJson
          .map((e) => AmenityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'hourlyRate': hourlyRate,
    'images': images.map((e) => e.toJson()).toList(),
    'amenities': amenities.map((e) => e.toJson()).toList(),
    'lat': lat,
    'lng': lng,
  };

  @override
  List<Object?> get props => [
    id,
    title,
    hourlyRate,
    images,
    amenities,
    lat,
    lng,
  ];
}
