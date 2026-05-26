class CourtModel {
  final int id;
  final String name;
  final String sport;
  final String location;
  final double rating;
  final int pricePerHour;
  final String distance;
  final String imageUrl;

  const CourtModel({
    required this.id,
    required this.name,
    required this.sport,
    required this.location,
    required this.rating,
    required this.pricePerHour,
    required this.distance,
    required this.imageUrl,
  });

  factory CourtModel.fromJson(Map<String, dynamic> json) {
    return CourtModel(
      id: json['id'] as int,
      name: json['name'] as String,
      sport: json['sport'] as String,
      location: json['location'] as String,
      rating: (json['rating'] as num).toDouble(),
      pricePerHour: json['pricePerHour'] as int,
      distance: json['distance'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sport': sport,
      'location': location,
      'rating': rating,
      'pricePerHour': pricePerHour,
      'distance': distance,
      'imageUrl': imageUrl,
    };
  }
}
