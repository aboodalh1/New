import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/constant.dart';
import 'package:qrreader/core/util/asset_loader.dart';
import 'package:qrreader/feature/Auth/presentation/view/widgets/mobile_widgets/mobile_login_card.dart';
import '../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../manger/auth_cubit.dart';

class MobileSignInPage extends StatelessWidget {
  const MobileSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is SignInLoadingState){
          customSnackBar(context, 'Loading...',color: kUnsubsicriber,duration:  20);
        }
        if (state is SignInFailureState) {
          if(state.error=='Session Expired'){
            customSnackBar(context, 'Wrong password or phone number', color: kOnWayColor);
          }
          else customSnackBar(context, state.error, color: kOnWayColor);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = context.read<AuthCubit>();
        return Scaffold(
            backgroundColor: kPrimaryColor,
            body: Column(
              children: [
                Image.asset(AssetsLoader.logo,width: 200.w,height: 200.h,),
                Center(
                  child: MobileLoginCard(authCubit: authCubit),
                ),
              ],
            ));
      },
    );
  }
}


