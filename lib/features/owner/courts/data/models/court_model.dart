import 'package:equatable/equatable.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';
import 'amenity_model.dart';
import 'court_image_model.dart';

class CourtModel extends Equatable {
  final String id;
  final String title;
  final double hourlyRate;
  final double offPeakRate;
  final double peakRate;
  final double membershipDiscount;
  final List<CourtImageModel> images;
  final List<AmenityModel> amenities;
  final String address;
  final bool isActive;
  final double rating;
  final int reviewCount;

  const CourtModel({
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
  });

  CourtModel copyWith({
    String? id,
    String? title,
    double? hourlyRate,
    double? offPeakRate,
    double? peakRate,
    double? membershipDiscount,
    List<CourtImageModel>? images,
    List<AmenityModel>? amenities,
    String? address,
    bool? isActive,
    double? rating,
    int? reviewCount,
  }) {
    return CourtModel(
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
    );
  }

  // ─── Safe parsing helpers ────────────────────────────────────────────────────
  // The backend may return numeric fields as String, int, or double.
  // These helpers tolerate all variations without throwing.

  static double _toDouble(dynamic v, [double fallback = 0.0]) {
    if (v == null) return fallback;
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v) ?? fallback;
    return fallback;
  }

  static int _toInt(dynamic v, [int fallback = 0]) {
    if (v == null) return fallback;
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v) ?? fallback;
    return fallback;
  }

  static bool _toBool(dynamic v, [bool fallback = true]) {
    if (v == null) return fallback;
    if (v is bool) return v;
    if (v is String) return v.toLowerCase() == 'true' || v == '1';
    if (v is int) return v != 0;
    return fallback;
  }

  // ─── fromJson ───────────────────────────────────────────────────────────────

  factory CourtModel.fromJson(Map<String, dynamic> json) {
    print('[CourtModel] Parsing court JSON keys: ${json.keys.toList()}');

    // Backend list endpoint returns: field_id, name, price_per_hour, field_images
    // Backend detail endpoint may return: id, title, hourly_rate, images
    // Fallback chains handle both shapes without crashes.
    final rawImages =
        (json['field_images'] ?? json['images']) as List<dynamic>? ?? [];
    
    // The backend uses boolean flags for amenities instead of a list
    final List<AmenityModel> parsedAmenities = [];
    if (_toBool(json['has_lights'], false)) {
      parsedAmenities.add(const AmenityModel(id: 'lights', title: 'Lights', iconAsset: ''));
    }
    if (_toBool(json['has_showers'], false)) {
      parsedAmenities.add(const AmenityModel(id: 'showers', title: 'Showers', iconAsset: ''));
    }
    if (_toBool(json['has_cafe'], false)) {
      parsedAmenities.add(const AmenityModel(id: 'cafe', title: 'Cafe', iconAsset: ''));
    }
    if (_toBool(json['has_equipment'], false)) {
      parsedAmenities.add(const AmenityModel(id: 'equipment', title: 'Equipment', iconAsset: ''));
    }
    // Fallback if backend ever sends the list directly
    final rawAmenities = json['amenities'] as List<dynamic>?;
    if (rawAmenities != null) {
      parsedAmenities.addAll(rawAmenities.map((e) => AmenityModel.fromJson(e as Map<String, dynamic>)));
    }

    final model = CourtModel(
      id: (json['field_id'] ?? json['id'])?.toString() ?? '',
      title: (json['name'] ?? json['title'])?.toString() ?? '',
      hourlyRate: _toDouble(json['price_per_hour'] ?? json['hourly_rate']),
      offPeakRate: _toDouble(json['off_peak_rate']),
      peakRate: _toDouble(json['peak_rate'] ?? json['price_per_hour'] ?? json['hourly_rate']),
      membershipDiscount: _toDouble(json['membership_discount']),
      images: rawImages
          .map((e) => CourtImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      amenities: parsedAmenities,
      address: json['address']?.toString() ?? '',
      isActive: _toBool(json['is_active']),
      rating: _toDouble(json['rating']),
      reviewCount: _toInt(json['review_count']),
    );

    print('[CourtModel] Parsed → id=${model.id}, title=${model.title}, '
        'rate=${model.hourlyRate}, images=${model.images.length}, '
        'amenities=${model.amenities.length}');
    return model;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'hourly_rate': hourlyRate,
        'off_peak_rate': offPeakRate,
        'peak_rate': peakRate,
        'membership_discount': membershipDiscount,
        'images': images.map((e) => e.toJson()).toList(),
        'amenities': amenities.map((e) => e.toJson()).toList(),
        'address': address,
        'is_active': isActive,
        'rating': rating,
        'review_count': reviewCount,
      };

  CourtEntity toEntity() {
    return CourtEntity(
      id: id,
      title: title,
      hourlyRate: hourlyRate,
      offPeakRate: offPeakRate,
      peakRate: peakRate,
      membershipDiscount: membershipDiscount,
      images: images.map((img) => img.toEntity()).toList(),
      amenities: amenities.map((am) => am.toEntity()).toList(),
      address: address,
      isActive: isActive,
      rating: rating,
      reviewCount: reviewCount,
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
      ];
}
