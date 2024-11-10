import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qrreader/core/failure/failure.dart';
import 'package:qrreader/core/util/api_service.dart';
import 'package:qrreader/feature/home_page/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo{
  DioHelper dioHelper;
  HomeRepoImpl(this.dioHelper);
  @override
  Future<Either<Failure, Response>> getAllReads() async{
    try{
      var response = await dioHelper.getData(endPoint: '/reads/list');
      return right(response);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> getMyInfo() async{
    try{
      var response = await dioHelper.getData(endPoint: '/users/my-info');
      return right(response);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
  @override
  Future<Either<Failure, Response>> signOut() async {
    try {
      var response = await dioHelper.postData(
          endPoint: '/users/logout', data: {});

      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
  }

