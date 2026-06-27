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
    // Check which shape we have
    final bool isNestedShape = json.containsKey('user');
    final bool isTokensShape = json.containsKey('tokens');

    // Extract user data
    final user = isNestedShape
        ? json['user'] as Map<String, dynamic>
        : json; // flat shape - user data is in root

    // Extract tokens
    String? accessToken;
    String? refreshToken;

    if (isTokensShape) {
      // Signup shape: { "tokens": { "access": "...", "refresh": "..." } }
      final tokens = json['tokens'] as Map<String, dynamic>?;
      accessToken = tokens?['access'] as String?;
      refreshToken = tokens?['refresh'] as String?;
    } else {
      // Login shape: { "access": "...", "refresh": "..." }
      accessToken = json['access'] as String?;
      refreshToken = json['refresh'] as String?;
    }

    return Usermodel(
      id: (user['id'] ?? user['user_id']) as int?,
      fullName: user['full_name'] as String?,
      username: user['username'] as String?,
      email: user['email'] as String?,
      phoneNumber: user['phone_number'] as String?,
      userType: (user['user_type']) as String?,
      profileImage: user['profile_image'] as String?,
      token: accessToken,
      refreshToken: refreshToken,
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
