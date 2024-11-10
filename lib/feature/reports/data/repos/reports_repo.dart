import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/failure/failure.dart';

abstract class ReportsRepo{


  Future<Either<Failure, Response>> getReports({required String date});

}