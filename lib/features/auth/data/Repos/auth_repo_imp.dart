import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/core/network/api_endpoints.dart';
import 'package:mala3bna/core/network/dio_client.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/features/auth/data/Repos/auth_repo.dart';
import 'package:mala3bna/features/auth/data/models/usermodel.dart';

class AuthRepoImp implements AuthRepo {
  final DioClient _client;
  final LocalStorageHelper _storage;

  AuthRepoImp({required DioClient client, required LocalStorageHelper storage})
    : _client = client,
      _storage = storage;

  @override
  Future<Either<Failure, Usermodel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      // ── DEBUG: reveal exact API response structure ──────────────────────────
      print('=== LOGIN RESPONSE ===');
      print('Type: ${response.runtimeType}');
      print('Keys: ${(response as Map<String, dynamic>).keys.toList()}');
      print('access: ${response['access']}');
      print('refresh: ${response['refresh']}');
      print('token: ${response['token']}');
      print('user key: ${response['user']}');
      print('Full response: $response');
      print('=== END LOGIN RESPONSE ===');
      // ── END DEBUG ───────────────────────────────────────────────────────────

      // Extract tokens BEFORE parsing into Usermodel
      final access = response['access'] as String?;
      final refresh = response['refresh'] as String?;

      // Handle nested user object: { "access": "...", "user": { ... } }
      final dynamic userJson = response['user'] ?? response;
      final user = Usermodel.fromJson(userJson as Map<String, dynamic>);

      if (access != null) {
        print('DEBUG: Saving JWT tokens — access=${access.substring(0, 20)}...');
        await _storage.saveTokens(access: access, refresh: refresh ?? '');
      } else if (user.token != null) {
        // Fallback: single-token response (non-JWT backend).
        print('DEBUG: Saving single token — ${user.token!.substring(0, 20)}...');
        await _storage.saveAccessToken(user.token!);
      } else {
        print('DEBUG: No token found in response!');
        return left(ServerFailure('Invalid token'));
      }

      // Verify token was actually saved
      final savedToken = await _storage.getAccessToken();
      print('DEBUG: Token saved successfully — ${savedToken != null ? 'YES (${savedToken.substring(0, 20)}...)' : 'NO — null!'}');

      return right(user);
    } on Failure catch (f) {
      print('DEBUG: Auth Failure — $f');
      return left(f);
    } catch (e) {
      print('DEBUG: Auth unexpected error — $e');
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Usermodel>> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role,
  }) async {
    try {
      final response = await _client.post(
        ApiEndpoints.signup,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
          'role': role,
        },
      );
      final user = Usermodel.fromJson(response as Map<String, dynamic>);

      final access = response['access'] as String?;
      final refresh = response['refresh'] as String?;
      if (access != null) {
        await _storage.saveTokens(access: access, refresh: refresh ?? '');
      } else if (user.token != null) {
        await _storage.saveAccessToken(user.token!);
      } else {
        return left(ServerFailure('Invalid token'));
      }
      return right(user);
    } on Failure catch (f) {
      return left(f);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
