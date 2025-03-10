import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/widgets/tablet/tablet_custom_loading_indicator.dart';
import 'package:qrreader/feature/messages/presentation/view/unverified/unverified_page_view.dart';
import 'package:qrreader/feature/messages/presentation/view/widgets/tablet/tablet_message_item.dart';

import '../../../../constant.dart';
import '../../../../core/util/function/navigation.dart';
import '../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../../Auth/presentation/view/sign_in_page.dart';
import '../manger/messages_cubit.dart';

class TabletMessagesPage extends StatelessWidget {
  const TabletMessagesPage({super.key});

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
        if (state is GetMessagesFailure) {
          if (state.error == 'Session Expired') {
            navigateAndFinish(context, const SignInPage());
          }
          customSnackBar(context, state.error);
        }
        if (state is GetMessagesSuccess) {}
      },
      builder: (context, state) {
        if (state is GetMessagesLoading || state is GetUnverifiedLoading) {
          return const TabletLoadingIndicator();
        }
        MessagesCubit messageCubit = context.read<MessagesCubit>();
        return Scaffold(
          body: SingleChildScrollView(
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
                      child: ElevatedButton(
                        onPressed: () {
                          navigateTo(
                              context,
                              BlocProvider.value(
                                value: messageCubit,
                                child: UnverifiedPageView(messagesCubit: messageCubit,),
                              ));
                        },
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            overlayColor: MaterialStateProperty.all(
                                Colors.black.withOpacity(0.25)),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 4.h)),
                            backgroundColor:
                                MaterialStateProperty.all(const Color(0xff77C6D8)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11.r),
                              ),
                            )),
                        child: Text(
                          'Unverified requests',
                          style: TextStyle(
                              fontSize: 5.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                  title: Text(
                    "Messages List",
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  child: SizedBox(
                                      child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => TabletMessageItem(
                        messagesCubit: messageCubit, index: index),
                    separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                          child: const Divider(
                            color: Colors.black,
                            thickness: 0.5,
                          ),
                        ),
                    itemCount: messageCubit.allMessagesModel.data.length),
                                    ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
