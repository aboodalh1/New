import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/constant.dart';

import '../../../../../../core/util/screen_util.dart';


class MobileCustomUnderLineTextField extends StatelessWidget {
  const MobileCustomUnderLineTextField({
    super.key,
    required this.hint, required this.controller,
    required this.onTap
  });
  final TextEditingController controller;
  final  GestureTapCallback onTap;
  final String hint;

  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return Container(
      height: 30,
      margin: EdgeInsets.symmetric(horizontal: 10.w,),
      child: TextSelectionTheme(
        data: const TextSelectionThemeData(
            cursorColor: kPrimaryColor , selectionHandleColor: kPrimaryColor , selectionColor: kPrimaryColor),
        child: TextFormField(
          onTap: onTap,
          controller: controller,
          style: TextStyle(fontSize:10.sp),
          cursorColor: kPrimaryColor,
          cursorErrorColor: kPrimaryColor,
          decoration:
          InputDecoration(
              border: const UnderlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
              enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
            hoverColor: kPrimaryColor,
            focusColor: kPrimaryColor,
              hintText: hint, hintStyle:TextStyle(fontSize: 8.sp),),
        ),
      ),
    );
  }
}
