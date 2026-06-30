class OwnerProfileModel {
  final String username;
  final String fullName;
  final String birthDate;
  final String gender;
  final String phone;
  final String email;
  final String bio;
  final String imageUrl;

  OwnerProfileModel({
    required this.username,
    required this.fullName,
    required this.birthDate,
    required this.gender,
    required this.phone,
    this.email = '',
    this.bio = '',
    required this.imageUrl,
  });

  OwnerProfileModel copyWith({
    String? username,
    String? fullName,
    String? birthDate,
    String? gender,
    String? phone,
    String? email,
    String? bio,
    String? imageUrl,
  }) {
    return OwnerProfileModel(
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
