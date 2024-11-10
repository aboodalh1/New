import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:qrreader/core/util/api_service.dart';
import 'package:qrreader/feature/bags/presentation/view/bags_page_view.dart';
import 'package:qrreader/feature/customers/presentation/view/customer_page_view.dart';
import 'package:qrreader/feature/home_page/data/model/home_reads_model.dart';
import 'package:qrreader/feature/home_page/data/repos/home_repo.dart';
import 'package:qrreader/feature/home_page/presentation/view/home_page.dart';
import 'package:qrreader/feature/reports/presentation/view/reports_page.dart';
import 'package:qrreader/feature/users/presentation/view/users_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  int currentIndex = 0;
  List<Widget> screens = [
    const HomePage(),
    const CustomerPageView(),
    const UsersPage(),
    const ReportsPage(),
    const BagsPageView(),
  ];
  List<String> screensTitle = [
    "Home Page",
    "Customers Page",
    "Users Page",
    "Reports Page",
    "Bags Page",
  ];

  changePage({required int index}) {
    currentIndex = index;

    emit(ChangePage());
  }

  void initialPage({required String lastRoute}) {
    if (lastRoute == 'home') {
      currentIndex = 0;
    } else if (lastRoute == 'customers') {
      currentIndex = 1;
    } else if (lastRoute == 'users') {
      currentIndex = 2;
    } else if (lastRoute == 'reports') {
      currentIndex = 3;
    } else if (lastRoute == 'bags') {
      currentIndex = 4;
    }
    emit(InitialPage());
  }

  SharedPreferences? prefs;

  void initCache() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> storeLastRoute(String lastRoute) async {
    await prefs!.setString('last_route', lastRoute);
  }

  HomeRepo homeRepo;
  HomeReadsModel homeReadsModel =
      HomeReadsModel(code: 1, message: '', data: []);
  Future<void> getAllReads() async {
    emit(GetReadsLoadingState());
    var result = await homeRepo.getAllReads();
    result.fold((failure) {
      emit(GetReadsFailureState(error: failure.errMessage));
    }, (response) {
      homeReadsModel = HomeReadsModel.fromJson(response.data);
      if (homeReadsModel.data.isEmpty) {
        emit(EmptyReadsState(message: response.data['message']));
      } else {
        emit(GetReadsSuccessState(message: homeReadsModel.message));
      }
    });
  }
  String currentName = '';
  void getCurrentName()async {
    currentName = await DioHelper.getName()??'';
  }

  Future<void> signOut() async {
    emit(SignOutLoadingState());
    var result = await homeRepo.signOut();
    result.fold((failure) {
      emit(SignOutFailureState(error: failure.errMessage));
    }, (response) {
      emit(SignOutSuccessState(message: response.data['message']));
    });
  }



}
