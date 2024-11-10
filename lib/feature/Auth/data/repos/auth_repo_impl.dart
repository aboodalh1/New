import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qrreader/core/failure/failure.dart';
import 'package:qrreader/core/util/api_service.dart';
import 'package:qrreader/feature/Auth/data/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  DioHelper dioHelper;

  AuthRepoImpl(this.dioHelper);

  @override
  Future<Either<Failure, Response>> login(
      {required String phone, required String password}) async {
    try {
      var response = await dioHelper.postData(
          endPoint: '/users/login',
          data: {'phone': phone, 'password': password});
      await DioHelper.setConnectionParameter(token: response.data['data']['token'],id: response.data['data']['id'],name:response.data['data']['name']);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

@override
  Future<Either<Failure, Response>> getMyInfo() async {
    try {
      var response = await dioHelper.getData(endPoint: '/users/my-info');
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> forgetPassword() {
    throw UnimplementedError();
  }


}
