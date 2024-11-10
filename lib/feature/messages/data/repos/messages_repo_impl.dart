import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qrreader/core/failure/failure.dart';
import 'package:qrreader/core/util/api_service.dart';
import 'messages_repo.dart';

class MessagesRepoImpl implements MessagesRepo {
  DioHelper dioHelper;

  MessagesRepoImpl(this.dioHelper);
  @override
  Future<Either<Failure, Response>> getAllUnverified() async{
    try{
      var response = await dioHelper.getData(endPoint: '/users/list-unverified');
      return right(response);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
  @override
  Future<Either<Failure, Response>> acceptUser({required num id}) async {
    try {
      var response = await dioHelper
          .postData(endPoint: '/users/accept-user', data: {'id': id});
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> getAllMessages() async {
    try {
      var response = await dioHelper.getData(endPoint: '/users/list-messages');
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> getAllRegisters() async {
    try {
      var response =
          await dioHelper.getData(endPoint: '/users/list-unverified');
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> rejectUser({required num id}) async {
    try {
      var response =
          await dioHelper.postData(endPoint: '/users/delete', data: {'id': id});
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
