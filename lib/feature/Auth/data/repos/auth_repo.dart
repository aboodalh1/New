import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/failure/failure.dart';

abstract class AuthRepo{
  Future<Either<Failure,Response>> login({required String phone,required String password});
  Future<Either<Failure,Response>> forgetPassword();
  Future<Either<Failure,Response>> getMyInfo();
}