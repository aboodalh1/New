import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constant.dart';
import '../../manger/customer_cubit.dart';

class SelectButton extends StatelessWidget {
  const SelectButton({
    super.key,
    required this.customerCubit,
  });

  final CustomerCubit customerCubit;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        customerCubit.expandButton();
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
          backgroundColor: MaterialStateProperty.all(
              kSecondaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: !customerCubit.isExpand
                  ? BorderRadius.circular(11.r)
                  : BorderRadius.only(
                  topLeft: Radius.circular(11.r),
                  topRight: Radius.circular(11.r)),
            ),
          )),
      child: Text(
        'Select',
        style: TextStyle(
            fontSize: 4.sp,
            fontWeight: FontWeight.w300,
            color: Colors.white),
      ),
    );
  }
}
