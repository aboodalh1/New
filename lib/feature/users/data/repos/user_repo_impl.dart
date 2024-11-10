
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qrreader/core/failure/failure.dart';
import 'package:qrreader/feature/users/data/repos/user_repo.dart';

import '../../../../core/util/api_service.dart';

class UserRepoImpl implements UserRepo {
  DioHelper dioHelper;
  UserRepoImpl(this.dioHelper);
  @override
  Future<Either<Failure, Response>> addNewUser(
      {required String name,
      required String phone,
      required String role,
       required List<int> image,
      required String password,
      required String confirmPassword}) async{
        try{
          var response = await dioHelper.postData(
              endPoint: '/users/add-user', data:FormData.fromMap(
              image.isEmpty?  {
            "name":name,
            "phone":phone,
            "employee_number":"1243524543",
            "role":role,
                "password":password,
            "confirm_password":confirmPassword
          }:
              {
                "name":name,
                "phone":phone,
                "employee_number":"1243524543",
                "role":role,
                "image": await MultipartFile.fromBytes(image,
                    filename: phone,
                    contentType: Headers.jsonMimeType),
                "password":password,
                "confirm_password":confirmPassword
              }
          ));
          if (response.statusCode == 200) {
          } else {
          }
          return right(response);
        }catch(e){
          if(e is DioException){
            return left(ServerFailure.fromDioError(e));
          }
          return left(ServerFailure(e.toString()));
        }
    }

  @override
  Future<Either<Failure, Response>> deleteUser({required num id}) async{
    try{
      var response = await dioHelper.postData(endPoint: '/users/delete?id=$id', data: {});
      return right(response);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> editUser({required String name,
    required String phone,
    required String role,
    required List<int> image,

    required num id}) async{
    try{
      var response = await dioHelper.postData(endPoint: '/users/update',
          data: image.isEmpty?  {
            "name":name,
            "phone":phone,
            "employee_number":"1243524543",
            "role":role,
            "id":id
          }: {
        "name":name,
        "phone":phone,
        "employee_number":"1243524543",
        "image": await MultipartFile.fromBytes(image,
            filename: phone,
            contentType: Headers.jsonMimeType),
        "role":role,
        "id":id,
      });
      return right(response);
    }catch(e){
      print(e.toString());
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> getAllUsers({required String role}) async{
    try{
      var response = await dioHelper.getData(endPoint: '/users/list?role=$role');
      return right(response);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
