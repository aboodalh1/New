import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../constant.dart';
import '../../../../../users/presentation/manger/user_cubit.dart';
import '../../../manger/customer_cubit.dart';

class CustomerFailureBody extends StatelessWidget {
  const CustomerFailureBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Something went wrong",
                  style: TextStyle(
                    fontSize: 5.sp,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                        WidgetStateProperty.all(kSecondaryColor),
                        padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 8.h))),
                    onPressed: () {
                      context
                          .read<CustomerCubit>()
                          .getAllCustomers(role: 'all');
                      context.read<UserCubit>().getAllUser(role: 'driver');
                    },
                    child: const Text(
                      "Try again",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            )));
  }
}
