import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qrreader/core/failure/failure.dart';
import 'package:qrreader/core/util/api_service.dart';
import 'package:qrreader/feature/customers/data/repos/customers_repo.dart';

class CustomersRepoImpl implements CustomersRepo {
  DioHelper dioHelper;
  CustomersRepoImpl(this.dioHelper);

  @override
  Future<Either<Failure, Response>> getAllCustomers({required String role}) async{
    dioHelper.dio.options.headers['Accept'] = 'application/json';
    try{
      var response = await dioHelper.getData(endPoint: '/customers/list?state=$role');
      return right(response);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> getCustomersByDriver({required int driverID}) async{
    dioHelper.dio.options.headers['Accept'] = 'application/json';
    try{
      var response = await dioHelper.getData(endPoint: '/customers/list?state=all&driver_id=$driverID');

      return right(response);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

 @override
  Future<Either<Failure, Response>> searchCustomers({required String search}) async{
    try{
      var response = await dioHelper.getData(endPoint: '/customers/list?state=all&search=$search');
      print(response.data);

      return right(response);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> getAllDrivers() async{
    try{
      var response = await dioHelper.getData(endPoint: '/users/list?role=driver');
      return right(response);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure,Response>> addNewCustomer(
      {required String fullName,
      required String phoneNumber,
      required String location,
      required num driverID}) async{
    try{
      var response = await dioHelper.postData(endPoint: '/customers/add',data: {
        "name":fullName,
        'address':location,
        'phone':phoneNumber,
        'driver_id':driverID,
      });
      return right(response);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }



  @override
  Future<Either<Failure,Response>> editCustomer({required num driverId,required String phoneNumber,required String name,required String location,required num id}) async{
    try{
      var response = await dioHelper.postData(endPoint: '/customers/update',data: {
        "name":name,
        "address":location,
        "phone":phoneNumber,
        "driver_id":driverId,
        'id':id
      });
      return right(response);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, Response>> deleteCustomer(
      { required num id}) async{
    try{
      var response = await dioHelper.postData(endPoint: '/customers/delete?id=$id', data: {});
      return right(response);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure,Response>> activeCustomer({required num id}) async{
    try{
      var response = await dioHelper.postData(endPoint: '/customers/update',data: {
        'id':id,
        'state':'active',
      });
      return right(response);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> inActiveCustomerStatus(
      {required num id}) async{
    try{
      var response = await dioHelper.getData(endPoint: '/customers/inactive?id=$id');
      return right(response);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

}
