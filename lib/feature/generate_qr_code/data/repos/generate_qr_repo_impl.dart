import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qrreader/core/failure/failure.dart';
import 'package:qrreader/core/util/api_service.dart';
import 'package:qrreader/feature/generate_qr_code/data/repos/generate_qr_repo.dart';

class GenerateQrRepoImpl implements GenerateQrRepo{
  DioHelper dioHelper;
  GenerateQrRepoImpl(this.dioHelper);
  @override
  Future<Either<Failure, Response>> getAllCustomers() async{
    try{
      var response = await dioHelper.getData(endPoint: '/customers/list?state=active');
      return right(response);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> generateQr({required num customerID}) async{
    try{
      var response = await dioHelper.postData(endPoint: '/qr/generate', data: {
        'customer_id':customerID,
      });
      return right(response);
    }catch(e){
      if( e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}