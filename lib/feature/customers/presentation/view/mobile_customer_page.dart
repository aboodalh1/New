import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:qrreader/feature/customers/presentation/view/widgets/mobile/mobile_customer_grid.dart';
import 'package:qrreader/feature/home_page/presentation/view/widgets/mobile/mobile_custom_elevated_button.dart';
import '../../../../constant.dart';
import '../manger/customer_cubit.dart';

class MobileCustomerPage extends StatelessWidget {
  const MobileCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerState>(
        listener: (context, state) {
          if(state is GetCustomersSuccess){
            customSnackBar(context, state.message);
          }
          if(state is GetCustomersFailure){
            customSnackBar(context, state.error,color: kOnWayColor);
          }
          if(state is DeleteCustomerSuccessState){
            if(Navigator.of(context).canPop()){Navigator.of(context).pop();}
          }
        },
        builder: (context, state) {
          CustomerCubit customerCubit = context.read();
          return Scaffold(
            body: state is GetCustomersLoading  || state is EditCustomerLoading?
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
                            cursorColor: kPrimaryColor,
                              style:  TextStyle(height: 1.2, fontSize: 12.sp),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10.w),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Search',
                                  hintStyle: const TextStyle(height: 0.8),
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
  }
}
