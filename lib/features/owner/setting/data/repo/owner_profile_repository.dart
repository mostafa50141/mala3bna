import 'package:mala3bna/features/owner/setting/presentation/model/owner_profile_model.dart';

class OwnerProfileRepository {
  // Simulating in-memory storage for the session
  static OwnerProfileModel _mockData = OwnerProfileModel(
    username: "mostafa22",
    fullName: "Mostafa Abdelaziz",
    birthDate: "22 Apr 2004",
    gender: "Male",
    phone: "+20 123 456 7890",
    email: "mostafa.a@neonathletics.com",
    bio: "Midfielder at Cairo Sports Club. Passionate about tactical play and endurance training. Always looking for the next challenge.",
    imageUrl: "assets/images/app_logo.png",
  );

  Future<OwnerProfileModel> fetchProfile() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _mockData;
  }

  Future<void> updateProfile(OwnerProfileModel updatedProfile) async {
    await Future.delayed(const Duration(seconds: 1));
    _mockData = updatedProfile;
  }

  Future<void> deleteAccount({required String password}) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    // Simulate wrong password error (replace with real API validation)
    if (password.length < 4) {
      throw Exception('Incorrect password. Please try again.');
    }
    // Account deletion succeeds — in production, call your auth API here
  }
}
