import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/feature/customers/presentation/view/widgets/tablet/tablet_customer_grid.dart';

import '../../../../constant.dart';
import '../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../../home_page/presentation/view/widgets/desktop/custom_search_bar.dart';
import '../manger/customer_cubit.dart';

class TabletCustomerPage extends StatelessWidget {
  const TabletCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerState>(
        listener: (context, state) {
      if (state is GetCustomersSuccess) {
        customSnackBar(context, state.message);
      }
      if (state is GetCustomersFailure) {
        customSnackBar(context, state.error, color: kOnWayColor);
      }
    }, builder: (context, state) {
      if (state is GetCustomersLoading ||
          state is DeleteCustomerLoadingState ||
          state is EditCustomerLoading ||
          state is AddCustomersLoading) {
        return Scaffold(
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10.r)),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              width: 100.w,
              height: 200.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fetching Data",
                    style: TextStyle(
                        fontSize: 10.sp, color: const Color(0xffFFFFFF)),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      }
      CustomerCubit customerCubit = context.read<CustomerCubit>();
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 45.0, right: 10.w),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Column(
                  children: [
                     CustomSearchBar(
                       onChanged: (String val){
                         if(val.isEmpty){customerCubit.getAllCustomers(role: 'all');}
                         // customerCubit.searchCustomers(search: val);
                       },
                     ),
                    TabletCustomerGrid(
                      customerCubit: customerCubit,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            customerCubit.expandButton();
                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.25)),
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 5.w,vertical: 4.h)),
                              backgroundColor: MaterialStateProperty.all(kSecondaryColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(11.r),
                                    topRight: Radius.circular(11.r),
                                    bottomRight: !customerCubit.isExpand?Radius.circular(11.r):Radius.zero,
                                    bottomLeft: !customerCubit.isExpand?Radius.circular(11.r):Radius.zero,
                                  ),
                                ),
                              )),
                          child:  Text(
                            "Select",
                            style: TextStyle(
                                fontSize: 8.sp, fontWeight: FontWeight.w300, color: Colors.white),
                          ),
                        ),
                        customerCubit.isExpand
                            ? Container(
                          height: 120.h,
                          width: 39.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(11.r),
                                  bottomRight: Radius.circular(11.r)),
                              border: Border.all(color: kPrimaryColor)),
                          child: Column(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    customerCubit.getAllCustomers(
                                        role: 'active');
                                  },
                                  child: Text(
                                    "Active",
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 5.sp),
                                  )),
                              const Divider(),
                              TextButton(
                                  onPressed: () {
                                    customerCubit.getAllCustomers(
                                        role: 'inactive');
                                  },
                                  child: Text(
                                    "Inactive",
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 5.sp),
                                  )),
                              const Divider(),
                              TextButton(
                                  onPressed: () {
                                    customerCubit.getAllCustomers(
                                        role: 'all');
                                  },
                                  child: Text(
                                    "All",
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 5.sp),
                                  )),
                            ],
                          ),
                        )
                            : const SizedBox()
                      ],
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),
      );
    });
  }
}
