import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/util/screen_util.dart';


class TabletCustomUnderLineTextField extends StatelessWidget {
  const TabletCustomUnderLineTextField({
    super.key,
    required this.hint, required this.controller,
  });

  final String hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return SizedBox(
      height: 40.h,
      width: 55.w,
      child: TextFormField(
        controller: controller,
        decoration:
        InputDecoration(hintText: hint, hintStyle:TextStyle(fontSize: 5.sp),border: const UnderlineInputBorder()),
      ),
    );
  }
}
