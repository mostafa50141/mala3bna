class UserProfileModel {
  final int id;
  final String username;
  final String fullName;
  final String email;
  final String? phoneNumber;
  final String? bio;
  final String? profileImage;
  final String? instagramLink;
  final String? tiktokLink;
  final String? facebookLink;

  const UserProfileModel({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.bio,
    this.profileImage,
    this.instagramLink,
    this.tiktokLink,
    this.facebookLink,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json['id'] as int,
        username: json['username'] as String? ?? '',
        fullName: json['full_name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        phoneNumber: json['phone_number'] as String?,
        bio: json['bio'] as String?,
        profileImage: json['profile_image'] as String?,
        instagramLink: json['instagram_link'] as String?,
        tiktokLink: json['tiktok_link'] as String?,
        facebookLink: json['facebook_link'] as String?,
      );
}
