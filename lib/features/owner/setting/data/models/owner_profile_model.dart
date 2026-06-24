import 'package:mala3bna/features/owner/setting/domain/entities/user_entity.dart';

class OwnerProfileModel {
  final int? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? birthDate;
  final String? gender;
  final String? profileImage;
  final String? bio;

  OwnerProfileModel({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.birthDate,
    this.gender,
    this.profileImage,
    this.bio,
  });

  factory OwnerProfileModel.fromJson(Map<String, dynamic> json) {
    return OwnerProfileModel(
      id: json['id'] as int?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      birthDate: json['birth_date'] as String?,
      gender: json['gender'] as String?,
      profileImage: json['profile_image'] as String?,
      bio: json['bio'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (fullName != null) map['full_name'] = fullName;
    if (email != null) map['email'] = email;
    if (phoneNumber != null) map['phone_number'] = phoneNumber;
    if (bio != null) map['bio'] = bio;
    // Backend doesn't support birth_date or gender in users/me, but we keep them here safely.
    return map;
  }

  UserEntity toEntity() {
    // Parse dateOfBirth safely
    DateTime dob = DateTime.tryParse(birthDate ?? '') ?? DateTime(2000);
    // Parse gender safely (default male)
    Gender genderEnum = (gender?.toLowerCase() == 'female')
        ? Gender.female
        : Gender.male;

    return UserEntity(
      name: fullName ?? '',
      email: email ?? '',
      dateOfBirth: dob,
      gender: genderEnum,
      imageUrl: profileImage,
      phoneNumber: phoneNumber,
      bio: bio,
    );
  }

  factory OwnerProfileModel.fromEntity(UserEntity entity) {
    return OwnerProfileModel(
      fullName: entity.name,
      email: entity.email,
      birthDate: entity.dateOfBirth.toIso8601String().split('T').first,
      gender: entity.gender == Gender.female ? 'female' : 'male',
      phoneNumber: entity.phoneNumber,
      profileImage: entity.imageUrl,
      bio: entity.bio,
    );
  }
}
