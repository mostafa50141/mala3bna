import 'package:equatable/equatable.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';

class CourtImageModel extends Equatable {
  final String id;
  final String url;

  const CourtImageModel({required this.id, required this.url});

  CourtImageModel copyWith({String? id, String? url}) {
    return CourtImageModel(id: id ?? this.id, url: url ?? this.url);
  }

  factory CourtImageModel.fromJson(Map<String, dynamic> json) {
    print('[Courts] Parsing court image: $json');
    return CourtImageModel(
      // Django returns id as int — convert to String safely
      id: (json['image_id'] ?? json['id'])?.toString() ?? '',
      // Backend may send 'url' or 'image' as the image URL key
      url: (json['url'] ?? json['image'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'url': url};

  @override
  List<Object?> get props => [id, url];

  CourtImageEntity toEntity() {
    return CourtImageEntity(id: id, url: url);
  }
}
