import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/widgets/desktop/desktop_custom_loading_indicator.dart';

import '../../../../../constant.dart';
import '../../../../../core/util/function/navigation.dart';
import '../../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../../../Auth/presentation/view/sign_in_page.dart';
import '../../manger/messages_cubit.dart';
import '../widgets/desktop/desktop_message_item.dart';

class DesktopUnVerifiedPage extends StatelessWidget {
  const DesktopUnVerifiedPage({super.key});
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
          return DesktopLoadingIndicator();
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
                child: messageCubit.allUnverifiedModel.data.isEmpty?
                    Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: AppBar(
                            backgroundColor: Color(0xffF8F9FB),
                            title: Text(
                              "Messages List",
                              style: TextStyle(
                                  fontFamily: 'Mono',
                                  color: kSecondaryColor,
                                  fontSize: 5.sp,
                                  fontWeight: FontWeight.w500),
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
                            actions: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                                child: IconButton(onPressed: (){
                                  messageCubit.getAllUnverified();
                                }, icon: Icon(Icons.refresh,size: 8.sp,color: kSecondaryColor,),),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 250.h,),
                        Icon(Icons.verified,color: kSecondaryColor.withOpacity(0.4),
                        size: 20.sp,
                        ),
                        SizedBox(height: 5.h,),
                        Text("No Unverified Messages",style: TextStyle(
                          fontSize: 7.sp,color: Colors.black.withOpacity(0.5)
                        ),),
                      ],
                    ),)
                    :SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: AppBar(
                          backgroundColor: Color(0xffF8F9FB),
                          title: Text(
                            "Messages List",
                            style: TextStyle(
                                fontFamily: 'Mono',
                                color: kSecondaryColor,
                                fontSize: 5.sp,
                                fontWeight: FontWeight.w500),
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
                          actions: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                              child:  IconButton(onPressed: (){
                                messageCubit.getAllUnverified();
                              }, icon: Icon(Icons.refresh,size: 8.sp,color: kSecondaryColor,),),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                BlocProvider.value(
                                  value: messageCubit,
                                  child: DesktopUnverifiedItem(
                                      messagesCubit: messageCubit, index: index),
                                ),
                            separatorBuilder: (context, index) =>
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                                  child: const Divider(color: kSecondaryColor),
                                ),
                            itemCount: messageCubit.allUnverifiedModel.data.length),
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
