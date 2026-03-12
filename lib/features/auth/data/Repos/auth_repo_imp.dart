import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/auth/data/Repos/auth_repo.dart';
import 'package:mala3bna/features/auth/data/models/usermodel.dart';

class AuthRepoImp implements AuthRepo {
  @override
  Future<Either<Failure, Usermodel>> login({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Usermodel>> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role,
  }) {
    throw UnimplementedError();
  }
}
