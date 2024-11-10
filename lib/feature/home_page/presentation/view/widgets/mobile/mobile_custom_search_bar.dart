import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../constant.dart';

class MobileCustomSearchBar extends StatelessWidget {
  const MobileCustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 130.w,
      child: TextFormField(
          cursorErrorColor: kPrimaryColor,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.sp),
              focusColor: kPrimaryColor,
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                child: Icon(
                  Icons.search,
                  size: 15.sp,
                  color: Colors.black,
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  )))),
    );
  }
}
