import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/widgets/tablet/tablet_custom_loading_indicator.dart';
import 'package:qrreader/feature/messages/presentation/view/widgets/tablet/tablet_message_item.dart';

import '../../../../../constant.dart';
import '../../../../../core/util/function/navigation.dart';
import '../../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../../../Auth/presentation/view/sign_in_page.dart';
import '../../manger/messages_cubit.dart';

class TabletUnVerifiedPage extends StatelessWidget {
  const TabletUnVerifiedPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessagesCubit, MessagesState>(
      listener: (context, state) {
        if (state is AcceptUserFailure) {
          customSnackBar(context, state.error);
        }
        if (state is AcceptUserSuccess) {
          customSnackBar(context, state.message);
        }
        if (state is RejectUserFailure) {
          customSnackBar(context, state.error);
        }
        if (state is RejectUserSuccess) {
          customSnackBar(context, state.message);
        }
        if (state is GetUnverifiedFailure) {
          if (state.error == 'Session Expired') {
            navigateAndFinish(context, const SignInPage());
          }
          else {
            customSnackBar(context, state.error);
          }
        }
      },
      builder: (context, state) {
        if (state is GetUnverifiedLoading) {
          return const TabletLoadingIndicator();
        }
        if (state is GetUnverifiedFailure) {
          return Scaffold(
              body: Center(
                child: Column(
                  children: [
                    Text(state.error),
                  ],
                ),
              )
          );
        }
        MessagesCubit messageCubit = context.read<MessagesCubit>();
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 10, right: 20),
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    AppBar(
                      backgroundColor: const Color(0xffF8F9FB),
                      actions: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: Icon(Icons.refresh,size: 16.sp,color: const Color(0xff77C6D8),),
                        )
                      ],
                      title: Text(
                        "Unverified requests List",
                        style: TextStyle(
                            fontFamily: 'Mono',
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500,
                            color: kSecondaryColor),
                      ),
                      leading: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: kSecondaryColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child:  messageCubit.allUnverifiedModel.data.isEmpty?
                      Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 250.h,),
                          Icon(Icons.verified,color: kSecondaryColor.withOpacity(0.4),
                            size: 25.sp,
                          ),
                          SizedBox(height: 5.h,),
                          Text("No Unverified Messages",style: TextStyle(
                              fontSize: 10.sp,color: Colors.black.withOpacity(0.5)
                          ),),
                        ],
                      ),):SizedBox(
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                BlocProvider.value(
                                  value: messageCubit,
                                  child: TabletUnverifiedItem(
                                      messagesCubit: messageCubit, index: index),
                                ),
                            separatorBuilder: (context, index) =>
                            const Divider(color: kSecondaryColor),
                            itemCount: messageCubit.allUnverifiedModel.data.length),
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
