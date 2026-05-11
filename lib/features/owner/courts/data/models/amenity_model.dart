import 'package:equatable/equatable.dart';

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

  factory AmenityModel.fromJson(Map<String, dynamic> json) => AmenityModel(
    id: json['id'] as String,
    title: json['title'] as String,
    iconAsset: json['iconAsset'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'iconAsset': iconAsset,
  };

  @override
  List<Object?> get props => [id, title, iconAsset];
}
