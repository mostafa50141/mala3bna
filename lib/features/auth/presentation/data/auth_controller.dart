import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mala3bna/core/role/user_role.dart';

class AuthController extends GetxController {
  final GetStorage _box = GetStorage();

  Rx<UserRole?> userRole = Rx<UserRole?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadSavedRole();
  }

  void setRole(UserRole role) {
    userRole.value = role;
    _box.write('role', role.name);
  }

  void _loadSavedRole() {
    final savedRole = _box.read('role');

    if (savedRole != null) {
      userRole.value = UserRole.values.firstWhere((e) => e.name == savedRole);
    }
  }

  void logout() {
    _box.remove('role');
    userRole.value = null;
  }
}
