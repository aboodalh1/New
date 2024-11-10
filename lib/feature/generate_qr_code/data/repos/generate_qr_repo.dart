import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/failure/failure.dart';

abstract class GenerateQrRepo {

  Future<Either<Failure, Response>> getAllCustomers();
  Future<Either<Failure, Response>> generateQr({required num customerID});

}