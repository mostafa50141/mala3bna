class Usermodel {
  int? id;
  String? fullName;
  String? username;
  String? email;
  String? phoneNumber;
  String? userType;
  String? profileImage;
  String? token; // access token
  String? refreshToken; // refresh token

  Usermodel({
    this.id,
    this.fullName,
    this.username,
    this.email,
    this.phoneNumber,
    this.userType,
    this.profileImage,
    this.token,
    this.refreshToken,
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    // API returns { access, refresh, user: {...} } for login
    // OR { tokens: { access, refresh }, user: {...} } for signup
    // OR just user fields directly
    final user = json['user'] as Map<String, dynamic>? ?? json;
    final tokens = json['tokens'] as Map<String, dynamic>?;

    return Usermodel(
      id: user['id'] as int?,
      fullName: user['full_name'] as String?,
      username: user['username'] as String?,
      email: user['email'] as String?,
      phoneNumber: user['phone_number'] as String?,
      userType: user['user_type'] as String?,
      profileImage: user['profile_image'] as String?,
      token: tokens?['access'] as String? ?? json['access'] as String?,
      refreshToken: tokens?['refresh'] as String? ?? json['refresh'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'full_name': fullName,
    'username': username,
    'email': email,
    'phone_number': phoneNumber,
    'user_type': userType,
    'profile_image': profileImage,
    'access': token,
    'refresh': refreshToken,
  };
}
