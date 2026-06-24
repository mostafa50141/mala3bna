import 'package:equatable/equatable.dart';

// ─── AmenityEntity ────────────────────────────────────────────────────────────

class AmenityEntity extends Equatable {
  final String id;
  final String title;
  final String iconAsset;

  const AmenityEntity({
    required this.id,
    required this.title,
    this.iconAsset = '',
  });

  @override
  List<Object?> get props => [id, title, iconAsset];
}

// ─── CourtImageEntity ─────────────────────────────────────────────────────────

class CourtImageEntity extends Equatable {
  final String id;
  final String url;

  const CourtImageEntity({required this.id, required this.url});

  @override
  List<Object?> get props => [id, url];
}

// ─── CourtEntity ──────────────────────────────────────────────────────────────

class CourtEntity extends Equatable {
  final String id;
  final String title;
  final double hourlyRate;
  final List<CourtImageEntity> images;
  final List<AmenityEntity> amenities;
  final String address;
  final bool isActive;
  final double rating;
  final int reviewCount;

  const CourtEntity({
    required this.id,
    required this.title,
    required this.hourlyRate,
    required this.images,
    required this.amenities,
    this.address = '',
    this.isActive = true,
    this.rating = 0.0,
    this.reviewCount = 0,
  });

  CourtEntity copyWith({
    String? id,
    String? title,
    double? hourlyRate,
    List<CourtImageEntity>? images,
    List<AmenityEntity>? amenities,
    String? address,
    bool? isActive,
    double? rating,
    int? reviewCount,
  }) {
    return CourtEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      images: images ?? this.images,
      amenities: amenities ?? this.amenities,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        hourlyRate,
        images,
        amenities,
        address,
        isActive,
        rating,
        reviewCount,
      ];
}
