import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrreader/core/util/screen_util.dart';
import 'package:qrreader/core/util/service_locator.dart';
import 'package:qrreader/feature/Auth/data/repos/auth_repo_impl.dart';
import 'package:qrreader/feature/Auth/presentation/manger/auth_cubit.dart';
import 'package:qrreader/feature/Auth/presentation/view/desktop_sign_in_page.dart';
import 'package:qrreader/feature/Auth/presentation/view/mobile_sign_in_page.dart';
import 'package:qrreader/feature/Auth/presentation/view/tablet_sign_in_page.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/manger/qrs_list_to_download_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return LayoutBuilder(builder: (context, constraints) {
      if (ScreenSizeUtil.screenWidth <= 700) {
        return MultiBlocProvider(
          providers: [
             BlocProvider(
          create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
             ),
             BlocProvider.value(value: BlocProvider.of<QrsListToDownloadCubit>(context),),
          ],
          child: const MobileSignInPage(),
        );
      }
      if (ScreenSizeUtil.screenWidth <= 1000) {
        return MultiBlocProvider(
          providers: [
             BlocProvider(
          create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
             ),
             BlocProvider.value(value: BlocProvider.of<QrsListToDownloadCubit>(context),),
          ],
          child: const TabletSignInPage(),
        );} else {
        return MultiBlocProvider(
          providers: [
             BlocProvider(
          create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
             ),
             BlocProvider.value(value: BlocProvider.of<QrsListToDownloadCubit>(context),),
          ],
          child: const DesktopSignInPage(),
        );
      }
    });
  }
}
