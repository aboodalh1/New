import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:qrreader/core/util/api_service.dart';
import 'package:qrreader/core/util/screen_util.dart';
import 'package:qrreader/feature/bags/data/repos/bags_repo_impl.dart';
import 'package:qrreader/feature/customers/data/repos/customers_repo_impl.dart';
import 'package:qrreader/feature/generate_qr_code/data/repos/generate_qr_repo_impl.dart';
import 'package:qrreader/feature/home_page/data/repos/home_repo_impl.dart';
import 'package:qrreader/feature/messages/data/repos/messages_repo_impl.dart';
import 'package:qrreader/feature/reports/data/repos/reports_repo_impl.dart';
import 'package:qrreader/feature/users/data/repos/user_repo_impl.dart';

import '../../feature/Auth/data/repos/auth_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton(ScreenSizeUtil());
  getIt.registerSingleton(DioHelper(Dio()));
  getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl(getIt.get<DioHelper>()));
  getIt.registerSingleton<UserRepoImpl>(UserRepoImpl(getIt.get<DioHelper>()));
  getIt.registerSingleton<CustomersRepoImpl>(CustomersRepoImpl(getIt.get<DioHelper>()));
  getIt.registerSingleton<BagsRepoImpl>(BagsRepoImpl(getIt.get<DioHelper>()));
  getIt.registerSingleton<GenerateQrRepoImpl>(GenerateQrRepoImpl(getIt.get<DioHelper>()));
  getIt.registerSingleton<MessagesRepoImpl>(MessagesRepoImpl(getIt.get<DioHelper>()));
  getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(getIt.get<DioHelper>()));
  getIt.registerSingleton<ReportsRepoImpl>(ReportsRepoImpl(getIt.get<DioHelper>()));


}