import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constant.dart';
import '../../manger/customer_cubit.dart';

class ExpandedSheet extends StatelessWidget {
  const ExpandedSheet({
    super.key,
    required this.customerCubit,
  });

  final CustomerCubit customerCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 24.4.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(11.r),
              bottomRight: Radius.circular(11.r)),
          border:
          Border.all(color: kPrimaryColor)),
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
                    fontSize: 3.sp),
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
                    fontSize: 3.sp),
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
                    fontSize: 3.sp),
              )),
        ],
      ),
    );
  }
}
