class Usermodel {
  int? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? userType;
  dynamic profileImage;
  String? token;

  Usermodel({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.userType,
    this.profileImage,
    this.token,
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
    id: json['id'] as int?,
    fullName: json['full_name'] as String?,
    email: json['email'] as String?,
    phoneNumber: json['phone_number'] as String?,
    userType: json['user_type'] as String?,
    profileImage: json['profile_image'] as dynamic,
    token: json['token'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'full_name': fullName,
    'email': email,
    'phone_number': phoneNumber,
    'user_type': userType,
    'profile_image': profileImage,
    'token': token,
  };
}
