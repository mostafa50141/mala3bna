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
  final double hourlyRate;  // legacy — equals peakRate
  final double offPeakRate;
  final double peakRate;
  final double membershipDiscount; // percentage 0-100
  final List<CourtImageEntity> images;
  final List<AmenityEntity> amenities;
  final String address;
  final bool isActive;
  final double rating;
  final int reviewCount;
  final String? maintenanceType;
  final String? maintenanceDescription;

  const CourtEntity({
    required this.id,
    required this.title,
    required this.hourlyRate,
    this.offPeakRate = 0.0,
    this.peakRate = 0.0,
    this.membershipDiscount = 0.0,
    required this.images,
    required this.amenities,
    this.address = '',
    this.isActive = true,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.maintenanceType,
    this.maintenanceDescription,
  });

  CourtEntity copyWith({
    String? id,
    String? title,
    double? hourlyRate,
    double? offPeakRate,
    double? peakRate,
    double? membershipDiscount,
    List<CourtImageEntity>? images,
    List<AmenityEntity>? amenities,
    String? address,
    bool? isActive,
    double? rating,
    int? reviewCount,
    String? maintenanceType,
    String? maintenanceDescription,
  }) {
    return CourtEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      offPeakRate: offPeakRate ?? this.offPeakRate,
      peakRate: peakRate ?? this.peakRate,
      membershipDiscount: membershipDiscount ?? this.membershipDiscount,
      images: images ?? this.images,
      amenities: amenities ?? this.amenities,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      maintenanceType: maintenanceType ?? this.maintenanceType,
      maintenanceDescription: maintenanceDescription ?? this.maintenanceDescription,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        hourlyRate,
        offPeakRate,
        peakRate,
        membershipDiscount,
        images,
        amenities,
        address,
        isActive,
        rating,
        reviewCount,
        maintenanceType,
        maintenanceDescription,
      ];
}
