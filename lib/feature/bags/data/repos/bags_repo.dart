import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qrreader/core/failure/failure.dart';

abstract class BagsRepo {

  Future<Either<Failure, Response>> getAllBags({required String state});

  Future<Either<Failure, Response>> editBagsNumber({required num number});
  Future<Either<Failure, Response>> changeBagState({required num id});

}
