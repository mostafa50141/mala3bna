import 'package:equatable/equatable.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';

class AmenityModel extends Equatable {
  final String id;
  final String title;
  final String iconAsset;

  const AmenityModel({
    required this.id,
    required this.title,
    required this.iconAsset,
  });

  AmenityModel copyWith({String? id, String? title, String? iconAsset}) {
    return AmenityModel(
      id: id ?? this.id,
      title: title ?? this.title,
      iconAsset: iconAsset ?? this.iconAsset,
    );
  }

  factory AmenityModel.fromJson(Map<String, dynamic> json) {
    print('[Courts] Parsing amenity: $json');
    return AmenityModel(
      // Django returns id as int — convert to String safely
      id: json['id']?.toString() ?? '',
      title: (json['title'] ?? json['name'])?.toString() ?? '',
      // Backend may use 'icon', 'icon_asset', or 'iconAsset' — handle all
      iconAsset: (json['iconAsset'] ?? json['icon_asset'] ?? json['icon'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'iconAsset': iconAsset,
  };

  @override
  List<Object?> get props => [id, title, iconAsset];

  AmenityEntity toEntity() {
    return AmenityEntity(id: id, title: title, iconAsset: iconAsset);
  }
}
