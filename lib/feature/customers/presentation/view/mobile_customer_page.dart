import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:qrreader/feature/customers/presentation/view/widgets/mobile/mobile_customer_grid.dart';
import 'package:qrreader/feature/home_page/presentation/view/widgets/mobile/mobile_custom_elevated_button.dart';
import 'package:qrreader/feature/users/presentation/manger/user_cubit.dart';
import '../../../../constant.dart';
import '../../../../core/widgets/tablet/tablet_custom_loading_indicator.dart';
import '../manger/customer_cubit.dart';

class MobileCustomerPage extends StatelessWidget {
  const MobileCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
  builder: (context, state) {
    if (state is GetUsersLoadingState) {
      return const Center(
        child: TabletLoadingIndicator(),
      );
    }
    if (state is GetUsersFailureState) {
      return Scaffold(
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error,style: TextStyle(fontSize: 8.sp),),
                  SizedBox(height: 10.h,),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(kPrimaryColor)),
                      onPressed: () {
                        context.read<UserCubit>().getAllUser(role: 'driver');
                      },
                      child:
                      Text('Try Again',style: TextStyle(
                        fontSize: 8.sp,
                          color: Colors.white
                      ),)),
                ],
              )));
    }
    return BlocConsumer<CustomerCubit, CustomerState>(
        listener: (context, state) {
          if (state is GetCustomersSuccess) {
            customSnackBar(context, state.message);
          }
          if (state is GetCustomersFailure) {
            customSnackBar(context, state.error, color: kOnWayColor);
          }
          if (state is EditCustomerSuccess) {
            customSnackBar(context, state.message);
          }
          if (state is EditCustomerFailure) {
            customSnackBar(context, state.error, color: kOnWayColor);
          }
          if (state is AddCustomersSuccess) {
            customSnackBar(context, state.message);
          }
          if(state is DeleteCustomerLoadingState){
            if(Navigator.canPop(context))Navigator.of(context).pop();
          }
          if (state is DeleteCustomerSuccessState) {
            customSnackBar(context, state.message);
          }
          if (state is DeleteCustomerFailureState) {
            customSnackBar(context, state.error,color:kOnWayColor,duration: 20 );
          }
          if (state is AddCustomersFailure) {
            customSnackBar(context, state.error,color:kOnWayColor,duration: 20 );
          }
          if (state is EditCustomerFailure) {
            customSnackBar(context, state.error,color:kOnWayColor,duration: 20 );
          }
        },
        builder: (context, state) {
          CustomerCubit customerCubit = context.read();
          if(state is GetCustomersFailure){
            return Scaffold(
                body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.error,style: TextStyle(fontSize: 8.sp),),
                        SizedBox(height: 10.h,),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(kPrimaryColor)),
                            onPressed: () {
                              context.read<CustomerCubit>().getAllCustomers(role: 'all');
                            },
                            child:
                            Text('Try Again',style: TextStyle(
                                fontSize: 8.sp,
                                color: Colors.white
                            ),)),
                      ],
                    )));
          }
          return Scaffold( 
            body: state is DeleteCustomerLoadingState|| state is GetCustomersLoading  || state is EditCustomerLoading?
                  const Center(child: CircularProgressIndicator(color: kPrimaryColor,),)
                  :SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 20.0.h, right: 10.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 35,
                          width: 160.w,
                          child: TextFormField(
                            onChanged: (val){
                              customerCubit.searchCustomers(search: val);
                            },
                            cursorColor: kPrimaryColor,
                              style:  TextStyle(height: 1.2, fontSize: 12.sp),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10.w),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Search',
                                  hintStyle: const TextStyle(height: 0.8),
                                  enabledBorder:const OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: kPrimaryColor),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(11),
                                      )) , focusedBorder:const OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: kPrimaryColor),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(11),
                                      )) ,
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(11),
                                      )))),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        MobileCustomElevatedButton(
                          onPressed: () {},
                          title: 'Select',
                           fill: false,
                          ),
                      ],
                    ),
                    MobileCustomerGrid(
                      customerCubit: customerCubit,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  },
);
  }
}
