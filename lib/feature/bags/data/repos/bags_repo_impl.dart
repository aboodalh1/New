import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qrreader/core/failure/failure.dart';
import 'package:qrreader/core/util/api_service.dart';
import 'package:qrreader/feature/bags/data/repos/bags_repo.dart';

class BagsRepoImpl implements BagsRepo {
  DioHelper dioHelper;

  BagsRepoImpl(this.dioHelper);

  @override
  Future<Either<Failure, Response>> editBagsNumber(
      {required num number}) async {
    try {
      var response = await dioHelper.postData(
          endPoint: '/bags/add-bags-number', data: {'number': number});
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
  @override
  Future<Either<Failure, Response>> changeBagState(
      {required num id}) async {
    try {
      var response = await dioHelper.postData(
          endPoint: '/bags/change-state', data: {'id': id});
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> getAllBags({required String state}) async {
    try {
      var response =
          await dioHelper.getData(endPoint: '/bags/list?identifier=$state');
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
