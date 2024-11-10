import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qrreader/core/failure/failure.dart';

abstract class HomeRepo{

  Future<Either<Failure,Response>> getAllReads();
  Future<Either<Failure,Response>> getMyInfo();
  Future<Either<Failure,Response>> signOut();
}