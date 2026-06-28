class CourtModel {
  final int id;
  final String name;
  final String sport;
  final String location;
  final double rating;
  final double pricePerHour;
  final String distance;
  final String imageUrl;
  final double lat;
  final double lng;
  final String? description;
  final bool isActive;
  final bool hasLights;
  final bool hasShowers;
  final bool hasCafe;
  final bool hasEquipment;
  final List<String> images;

  const CourtModel({
    required this.id,
    required this.name,
    required this.sport,
    required this.location,
    this.rating = 0.0,
    required this.pricePerHour,
    this.distance = '',
    this.imageUrl = 'assets/images/Court.png',
    this.lat = 0.0,
    this.lng = 0.0,
    this.description,
    this.isActive = true,
    this.hasLights = false,
    this.hasShowers = false,
    this.hasCafe = false,
    this.hasEquipment = false,
    this.images = const [],
  });

  factory CourtModel.fromJson(Map<String, dynamic> json) {
    // Parse images from field_images array
    final fieldImages = json['field_images'] as List<dynamic>? ?? [];
    final images = fieldImages
        .map((img) => img['image'] as String? ?? '')
        .where((url) => url.isNotEmpty)
        .toList();

    return CourtModel(
      id: json['field_id'] as int,
      name: json['name'] as String? ?? '',
      sport: json['sport_type'] as String? ?? 'Football',
      location: json['address'] as String? ?? '',
      rating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
      pricePerHour: double.tryParse(
            json['price_per_hour']?.toString() ?? '0',
          ) ?? 0.0,
      lat: double.tryParse(json['latitude']?.toString() ?? '0') ?? 0.0,
      lng: double.tryParse(json['longitude']?.toString() ?? '0') ?? 0.0,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      hasLights: json['has_lights'] as bool? ?? false,
      hasShowers: json['has_showers'] as bool? ?? false,
      hasCafe: json['has_cafe'] as bool? ?? false,
      hasEquipment: json['has_equipment'] as bool? ?? false,
      imageUrl: images.isNotEmpty
          ? images.first
          : 'assets/images/Court.png',
      images: images,
      distance: '',
    );
  }
}
