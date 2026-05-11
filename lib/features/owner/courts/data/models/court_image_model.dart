import 'package:equatable/equatable.dart';

class CourtImageModel extends Equatable {
  final String id;
  final String url;

  const CourtImageModel({required this.id, required this.url});

  CourtImageModel copyWith({String? id, String? url}) {
    return CourtImageModel(id: id ?? this.id, url: url ?? this.url);
  }

  factory CourtImageModel.fromJson(Map<String, dynamic> json) =>
      CourtImageModel(id: json['id'] as String, url: json['url'] as String);

  Map<String, dynamic> toJson() => {'id': id, 'url': url};

  @override
  List<Object?> get props => [id, url];
}
