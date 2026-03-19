import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/auth/data/models/usermodel.dart';

abstract class AuthRepo {
  Future<Either<Failure, Usermodel>> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role,
  });
  Future<Either<Failure, Usermodel>> login({
    required String email,
    required String password,
  });
}
