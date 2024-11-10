import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qrreader/core/failure/failure.dart';

abstract class CustomersRepo {

  Future<Either<Failure, Response>> getAllCustomers({required String role});
  Future<Either<Failure, Response>> searchCustomers({required String search});
  Future<Either<Failure, Response>> getCustomersByDriver({required int driverID});
  Future<Either<Failure, Response>> getAllDrivers();
  Future<Either<Failure, Response>> addNewCustomer(
      {required String fullName,
        required String phoneNumber,
        required String location,
        required num driverID});


  Future<Either<Failure, Response>> deleteCustomer(
      {required num id});

  Future<Either<Failure, Response>> inActiveCustomerStatus(
      { required num id});

  Future<Either<Failure, Response>> activeCustomer({ required num id});

  Future<Either<Failure,Response>>editCustomer({required num driverId,required String phoneNumber,required String name,required String location,required num id});}
