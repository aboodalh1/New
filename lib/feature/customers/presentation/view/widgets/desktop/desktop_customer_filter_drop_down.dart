import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../constant.dart';
import '../../../manger/customer_cubit.dart';

class FilterDropDown extends StatelessWidget {
  const FilterDropDown({
    super.key,
    required this.customerCubit,
  });

  final CustomerCubit customerCubit;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(10.r),
            borderSide: BorderSide(
              color: kSecondaryColor,
              width: 0.5.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(10.r),
            borderSide: BorderSide(
              color: kSecondaryColor,
              width: 0.5.w,
            ),
          ),
        ),
        isExpanded: true,
        value: null,
        iconSize: 5.sp,
        isDense: true,
        hint: Text(
          customerCubit.newDriver,
          style: TextStyle(
              fontSize: 3.sp,
              color: const Color(0xFF000000)),
        ),
        items:
        drivers.map<DropdownMenuItem<String>>(
              (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          },
        ).toList(),
        onChanged: (val) {
          customerCubit.newDriver = val!;
          customerCubit.newDriver == 'all'
              ? customerCubit.getAllCustomers(
              role: 'all')
              : customerCubit.getCustomersByDriver(
              driverID: mapDrivers[
              customerCubit.newDriver]!);
          // customerCubit.getAllCustomers(role: 'role')
        });
  }
}