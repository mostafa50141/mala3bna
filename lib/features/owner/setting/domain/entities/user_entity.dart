enum Gender { male, female }

class UserEntity {
  final String name;
  final String email;
  final DateTime dateOfBirth;
  final Gender gender;
  final String? imageUrl;
  final String? phoneNumber;
  final String? bio;

  const UserEntity({
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    this.imageUrl,
    this.phoneNumber,
    this.bio,
  });

  UserEntity copyWith({
    String? name,
    String? email,
    DateTime? dateOfBirth,
    Gender? gender,
    String? imageUrl,
    String? phoneNumber,
    String? bio,
  }) {
    return UserEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
    );
  }
}
