

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qrreader/core/failure/failure.dart';

abstract class UserRepo {

  Future<Either<Failure, Response>> getAllUsers({required String role});

  Future<Either<Failure, Response>> addNewUser(
      {required String name,
      required String phone,
      required List<int> image,
      required String role,
      required String password,
      required String confirmPassword});

  Future<Either<Failure, Response>> editUser({required String name,
    required String phone,
    required String role,
    required List<int> image,

    required num id
  });

  Future<Either<Failure, Response>> deleteUser(
      {required num id});
}
