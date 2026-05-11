import 'package:equatable/equatable.dart';
import 'court_image_model.dart';

class UpdateCourtRequest extends Equatable {
  final String id;
  final double hourlyRate;
  final List<CourtImageModel> images;
  final List<String> amenityIds;
  final double lat;
  final double lng;

  const UpdateCourtRequest({
    required this.id,
    required this.hourlyRate,
    required this.images,
    required this.amenityIds,
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'hourlyRate': hourlyRate,
    'images': images.map((e) => e.toJson()).toList(),
    'amenityIds': amenityIds,
    'lat': lat,
    'lng': lng,
  };

  @override
  List<Object?> get props => [id, hourlyRate, images, amenityIds, lat, lng];
}
