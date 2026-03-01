enum Gender { male, female }

class UserEntity {
  final String username;
  final String name;
  final String email;
  final DateTime dateOfBirth;
  final Gender gender;
  final String? imageUrl;

  const UserEntity({
    required this.username,
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    this.imageUrl,
  });

  UserEntity copyWith({
    String? username,
    String? name,
    String? email,
    DateTime? dateOfBirth,
    Gender? gender,
    String? imageUrl,
  }) {
    return UserEntity(
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
