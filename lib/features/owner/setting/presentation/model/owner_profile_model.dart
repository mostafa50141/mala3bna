class OwnerProfileModel {
  final String username;
  final String fullName;
  final String birthDate;
  final String gender;
  final String phone;
  final String imageUrl;

  OwnerProfileModel({
    required this.username,
    required this.fullName,
    required this.birthDate,
    required this.gender,
    required this.phone,
    required this.imageUrl,
  });

  OwnerProfileModel copyWith({
    String? username,
    String? fullName,
    String? birthDate,
    String? gender,
    String? phone,
    String? imageUrl,
  }) {
    return OwnerProfileModel(
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
