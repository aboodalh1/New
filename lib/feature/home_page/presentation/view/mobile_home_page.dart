import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/util/function/navigation.dart';
import 'package:qrreader/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/view/generate_qr_page_view.dart';
import 'package:qrreader/feature/home_page/presentation/manger/home_cubit.dart';
import 'package:qrreader/feature/home_page/presentation/view/widgets/mobile/mobile_custom_elevated_button.dart';
import 'package:qrreader/feature/home_page/presentation/view/widgets/mobile/mobile_home_table.dart';
import 'package:qrreader/feature/messages/presentation/view/messages_page_view.dart';

import '../../../../constant.dart';
import '../../../customers/presentation/manger/customer_cubit.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetReadsSuccessState){
          customSnackBar(context, state.message);
        }
        if (state is GetReadsFailureState){
          customSnackBar(context, state.error,color: kOnWayColor,duration: 200);
        }
      },
      builder: (context, state) {
        HomeCubit homeCubit = context.read<HomeCubit>();
        return Scaffold(
          body: state is GetReadsLoadingState? const Center(
            child: CircularProgressIndicator(color: kPrimaryColor,),
          ):MobileHomeBody(homeCubit: homeCubit),
        );
      },
    );
  }
}

class MobileHomeBody extends StatelessWidget {
  const MobileHomeBody({super.key, required this.homeCubit});

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20.0, right: 10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Last Reads:",style: TextStyle(fontSize: 12.sp),),
                    SizedBox(
                      width: 80.w,
                    ),
                    IconButton(
                        tooltip: 'Refresh',
                        padding: EdgeInsets.zero,
                        onPressed: (){
                          context.read<HomeCubit>().getAllReads();
                        }, icon: Icon(Icons.refresh,size: 18.sp,color:kSecondaryColor,)),
                    IconButton(onPressed: (){
                      navigateTo(context, const MessagePageView());
                    }, icon: Icon(Icons.notifications,color: kSecondaryColor,size: 18.sp,)),
                    SizedBox(
                      width: 100.w,
                      height: 28,
                      child: MobileCustomElevatedButton(
                        fill: true,
                        title: 'Generate QR',
                        onPressed: () {
                          context.read<CustomerCubit>().getAllCustomers(role: 'all');
                          navigateTo(context, const GenerateQrPageViw());
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80.h,
                ),
                Center(child: MobileHomeTable(homeCubit: homeCubit))
              ],
            ),
          ),
        );
  }
}
