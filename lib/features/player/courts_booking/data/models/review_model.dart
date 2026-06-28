class ReviewModel {
  final int id;
  final int fieldId;
  final int userId;
  final String userName;
  final String? userImage;
  final int rating;
  final String comment;
  final String createdAt;

  const ReviewModel({
    required this.id,
    required this.fieldId,
    required this.userId,
    required this.userName,
    this.userImage,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json['id'] as int,
        fieldId: json['field'] as int,
        userId: json['user'] as int,
        userName: json['user_name'] as String? ?? 'Anonymous',
        userImage: json['user_image'] as String?,
        rating: json['rating'] as int? ?? 0,
        comment: json['comment'] as String? ?? '',
        createdAt: json['created_at'] as String? ?? '',
      );
}
