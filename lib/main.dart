import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qrreader/constant.dart';
import 'package:qrreader/core/util/api_service.dart';
import 'package:qrreader/core/util/service_locator.dart';
import 'package:qrreader/dashboard.dart';
import 'package:qrreader/feature/customers/data/repos/customers_repo_impl.dart';
import 'package:qrreader/feature/customers/presentation/manger/customer_cubit.dart';
import 'package:qrreader/feature/reports/data/repos/reports_repo_impl.dart';
import 'package:qrreader/feature/reports/presentation/manger/reports_cubit.dart';
import 'package:qrreader/feature/users/data/repos/user_repo_impl.dart';
import 'package:qrreader/feature/users/presentation/manger/user_cubit.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
import 'package:qrreader/feature/Auth/presentation/view/sign_in_page.dart';
import 'bloc_observer.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  setUrlStrategy(PathUrlStrategy());
  SharedPreferencesPlugin.registerWith(Registrar());
  UrlLauncherPlugin.registerWith(Registrar());
  await GetStorage.init();
  String lastToken=await DioHelper.getToken()??'';
  String lastRoute=await DioHelper.getLastRoute()??'home';
  setupServiceLocator();
  runApp( MyApp(startRoute: lastRoute,isToken: lastToken,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startRoute, required this.isToken});
  final String startRoute;
  final String isToken;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 660),
        child: MultiBlocProvider(
  providers: [
    BlocProvider(
  create: (context) => UserCubit(getIt.get<UserRepoImpl>())..getAllUser(role: 'all')..getCurrentUser(),
),
    BlocProvider(
      create: (context) => CustomerCubit(getIt.get<CustomersRepoImpl>())..getAllCustomers(role: 'all'),
    ),
    BlocProvider(
      create: (context) => ReportsCubit(getIt.get<ReportsRepoImpl>())..getAllReports(),
    ),
  ],
  child: MaterialApp(
          theme: ThemeData(
            textSelectionTheme: const TextSelectionThemeData(
              selectionColor: kSecondaryColor,
              selectionHandleColor: kPrimaryColor,
              cursorColor: kPrimaryColor
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: kPrimaryColor,
              titleTextStyle: TextStyle(color: Colors.white),
              iconTheme: IconThemeData(color: Colors.white)
            ),
              datePickerTheme: DatePickerThemeData(
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: kPrimaryColor),
                  ),
                ),
                
                cancelButtonStyle: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black)
                ),
                confirmButtonStyle: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(kSecondaryColor)
                ),
              ),
              fontFamily: 'Mono',
              scaffoldBackgroundColor: const Color(0xffF8F9FB)
          ),
          initialRoute: startRoute,
          home:  isToken!=''?DashboardPage(startRoute: startRoute,):const SignInPage(),
        ),
));
  }
}