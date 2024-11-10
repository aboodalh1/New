import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/constant.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Widget ?suffixIcon;
  final bool isTablet;
  final bool isCenter;
  final bool isSecure;
  const CustomTextField(
      {super.key,required this.isTablet, required this.controller, required this.label, this.suffixIcon, required this.isCenter, required this.isSecure});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12.r),
      shadowColor: Colors.black,
      elevation: 4,
      child: TextFormField(
        obscureText: isSecure,
          controller: controller,
          textAlign: isCenter? TextAlign.center:TextAlign.start,
          decoration: InputDecoration(
              suffixIcon: suffixIcon,
              fillColor: const Color(0xFFf2f2f2),
              filled: true,
              hintText: label,
              hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                  fontSize: isTablet? 5.sp:4.sp),
              focusColor: Colors.blue,
              enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(width: 0.58,color: Colors.black.withOpacity(.20)),
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(width: 0.58,color: Colors.black.withOpacity(.20)),
              ),
              floatingLabelStyle: const TextStyle(color: Colors.blue)),
          cursorColor: kPrimaryColor, ),
    );
  }
}
