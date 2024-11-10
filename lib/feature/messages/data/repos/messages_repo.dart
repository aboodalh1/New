import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/failure/failure.dart';

abstract class MessagesRepo{

  Future<Either<Failure, Response>> getAllMessages();
  Future<Either<Failure, Response>> getAllUnverified();
  Future<Either<Failure,Response>> acceptUser({required num id});
  Future<Either<Failure,Response>> rejectUser({required num id});
  Future<Either<Failure,Response>> getAllRegisters();
}