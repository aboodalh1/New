import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/widgets/desktop/desktop_custom_loading_indicator.dart';
import 'package:qrreader/feature/customers/presentation/manger/customer_cubit.dart';
import 'package:qrreader/feature/customers/presentation/view/widgets/customer_grid.dart';
import 'package:qrreader/feature/customers/presentation/view/widgets/desktop/desktop_customer_failure_body.dart';
import 'package:qrreader/feature/customers/presentation/view/widgets/desktop/desktop_customer_filter_drop_down.dart';
import 'package:qrreader/feature/customers/presentation/view/widgets/expanded_sheet.dart';
import 'package:qrreader/feature/customers/presentation/view/widgets/select_button.dart';
import 'package:qrreader/feature/users/presentation/manger/user_cubit.dart';
import '../../../../constant.dart';
import '../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../../home_page/presentation/view/widgets/desktop/custom_search_bar.dart';

class DesktopCustomerPage extends StatelessWidget {
  const DesktopCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is GetUsersLoadingState) {
          return Center(
            child: SizedBox(
                width: 35.w,
                height: 45.h,
                child: const DesktopLoadingIndicator()),
          );
        }
        if (state is GetUsersFailureState) {
          return UserLoadingFailureBody(state: state);
        }
        return BlocConsumer<CustomerCubit, CustomerState>(
            listener: (context, state) {
          if (state is DeleteCustomerSuccessState) {
            customSnackBar(context, state.message, color: kPrimaryColor);
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          }
          if (state is AddCustomersFailure) {
            customSnackBar(context, state.error,
                duration: 10, color: kOnWayColor);
          }
          if (state is DisAttachCustomerSuccessState) {
            customSnackBar(
              context,
              state.message,
              duration: 10,
            );
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          }
          if (state is DisAttachCustomerFailureState) {
            customSnackBar(context, state.error,
                duration: 10, color: kOnWayColor);
          }
          if (state is EditCustomerSuccess) {
            customSnackBar(context, state.message, duration: 10);
          }
          if (state is SearchCustomersFailure) {
            customSnackBar(context, state.error, color: kOnWayColor);
          }
          if (state is EditCustomerFailure) {
            customSnackBar(context, state.error,
                color: kOnWayColor, duration: 10);
          }
          if (state is GetCustomersLoading) {
            context.read<UserCubit>().getAllUser(role: 'driver');
          }
        }, builder: (context, state) {
          if (state is GetCustomersLoading ||
              state is GetCustomerByDriverLoadingState ||
              state is AddCustomersLoading ||
              state is EditCustomerLoading ||
              state is DeleteCustomerLoadingState) {
            return const Center(child: DesktopLoadingIndicator());
          }
          if (state is GetCustomersFailure) {
            return const CustomerFailureBody();
          }
          CustomerCubit customerCubit = context.read();
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 45.0, right: 25),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        CustomSearchBar(
                          onChanged: (String val) {
                            customerCubit.searchCustomers(search: val);
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 38.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Filter By Driver: ",
                                style: TextStyle(
                                    fontSize: 3.sp,
                                    color: const Color(0xFF000000)),
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              SizedBox(
                                width: 112.w,
                                child: FilterDropDown(
                                    customerCubit: customerCubit),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        state is SearchCustomersLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              )
                            : CustomerGrid(
                                customerCubit: customerCubit,
                              ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          iconSize: 8.sp,
                          icon: const Icon(
                            Icons.refresh,
                            color: kSecondaryColor,
                          ),
                          onPressed: () {
                            customerCubit.getAllCustomers(role: 'all');
                          },
                        ),
                        Column(
                          children: [
                            SelectButton(customerCubit: customerCubit),
                            customerCubit.isExpand
                                ? ExpandedSheet(customerCubit: customerCubit)
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
      },
    );
  }
}

class UserLoadingFailureBody extends StatelessWidget {
  const UserLoadingFailureBody({super.key, required this.state});

  final dynamic state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${state.error}',
          style: TextStyle(fontSize: 4.sp),
        ),
        SizedBox(
          height: 10.h,
        ),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
            onPressed: () {
              context.read<UserCubit>().getAllUser(role: 'driver');
            },
            child: const Text(
              'Try Again',
              style: TextStyle(color: Colors.white),
            )),
      ],
    )));
  }
}
