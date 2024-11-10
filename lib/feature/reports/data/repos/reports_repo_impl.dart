import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qrreader/core/failure/failure.dart';
import 'package:qrreader/core/util/api_service.dart';
import 'package:qrreader/feature/reports/data/repos/reports_repo.dart';

class ReportsRepoImpl implements ReportsRepo{
  DioHelper dioHelper;
  ReportsRepoImpl(this.dioHelper);

  @override
  Future<Either<Failure, Response>> getReports({required String date}) async{
    try{
      var response = await dioHelper.getData(endPoint: '/bags/report?date=$date');
      return right(response);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
  
}