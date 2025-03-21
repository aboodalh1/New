import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrreader/core/util/function/navigation.dart';
import 'package:qrreader/dashboard.dart';
import 'package:qrreader/feature/Auth/presentation/view/widgets/tablet_widgets/tablet_login_card.dart';
import 'package:qrreader/feature/Auth/presentation/view/widgets/title_on_image.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/manger/qrs_list_to_download_cubit.dart';

import '../../../../constant.dart';
import '../../../../core/util/asset_loader.dart';
import '../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../manger/auth_cubit.dart';

class TabletSignInPage extends StatelessWidget {
  const TabletSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is SignInLoadingState){
          customSnackBar(context, 'Loading...',color: kUnsubsicriber,duration: 200);
        }
         if (state is SignInFailureState) {
          if(state.error=='Session Expired'){
            customSnackBar(context, 'Wrong password or phone number', color: kOnWayColor);
          }
          else {
            customSnackBar(context, state.error, color: kOnWayColor);
          }
        }
if(state  is SignInSuccessState){
          navigateAndFinish(context, BlocProvider.value(value: BlocProvider.of<QrsListToDownloadCubit>(context),child: const DashboardPage(startRoute: 'home',)));

}
      },
      builder: (context, state) {
        AuthCubit authCubit = context.read<AuthCubit>();
        return Scaffold(
          body: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                    AssetsLoader.loginPic,
                    scale: 0.883,
                  ),
                  Image.asset(
                    AssetsLoader.loginPicShadow,
                  ),
                  const TitleOnImage(),
                  Center(
                    child: TabletLoginCard(
                      authCubit: authCubit,
                      context: context,
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
