import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/constant.dart';
import 'package:qrreader/core/util/screen_util.dart';
import 'package:qrreader/core/util/service_locator.dart';
import 'package:qrreader/core/widgets/custom_mobile_drawer.dart';
import 'package:qrreader/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:qrreader/feature/Auth/presentation/view/widgets/tablet_widgets/tablet_custom_drawer.dart';
import 'package:qrreader/feature/home_page/data/repos/home_repo_impl.dart';
import 'package:qrreader/feature/home_page/presentation/manger/home_cubit.dart';

import 'core/util/api_service.dart';
import 'core/util/function/navigation.dart';
import 'core/widgets/desktop_drawer.dart';
import 'feature/Auth/presentation/view/sign_in_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.startRoute});
  final String startRoute;
  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return BlocProvider(
      create: (context) => HomeCubit(getIt.get<HomeRepoImpl>())..initCache()..initialPage(lastRoute: startRoute)..getAllReads()..getCurrentName(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if(state is SignOutLoadingState){
            customSnackBar(context,'Loading',color: kUnsubsicriber,duration: 40);
          }
          if(state is SignOutSuccessState){
            DioHelper.removeToken();
            navigateAndFinish(context, const SignInPage());
          }
          if(state is SignOutFailureState){
            if(state.error=='Session Expired'){navigateAndFinish(context, SignInPage());}
            customSnackBar(context, state.error,color: kOnWayColor,duration: 10);
          }
        },
        builder: (context, state) {
          HomeCubit homeCubit = context.read<HomeCubit>();
          return Scaffold(
            appBar:ScreenSizeUtil.screenWidth<=1000? AppBar(
              title: Text(homeCubit.screensTitle[homeCubit.currentIndex],
              style: TextStyle(fontSize: 8.sp,fontFamily: 'Mono'),
              ),
            ):null,
            drawer: ScreenSizeUtil.screenWidth<=600?CustomMobileDrawer(homeCubit: homeCubit,):ScreenSizeUtil.screenWidth<=1000? TabletDrawer(homeCubit: homeCubit,):null,
              key: homeCubit.scaffoldKey,
              body: Row(
                children: [
                   if(ScreenSizeUtil.screenWidth >= 1000)  DesktopDrawer(homeCubit: homeCubit,),
                  Expanded(child: homeCubit.screens[homeCubit.currentIndex]),
                ],
              )
          );
        },
      ),
    );
  }
}
