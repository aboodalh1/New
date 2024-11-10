import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/constant.dart';

import '../util/screen_util.dart';

class CustomUnderLineTextField extends StatelessWidget {
  const CustomUnderLineTextField({
    super.key,
    required this.hint, required this.controller,
  });

  final String hint;
final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return SizedBox(
      height: 40,
      width: 40.w,
      child: TextFormField(
        controller: controller,
        cursorColor: kPrimaryColor,
        decoration:
        InputDecoration(
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
            hintText: hint, hintStyle:TextStyle(fontSize: ScreenSizeUtil.screenWidth*0.008),border: const UnderlineInputBorder()),
      ),
    );
  }
}
