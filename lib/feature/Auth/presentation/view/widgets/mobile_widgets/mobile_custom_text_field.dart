import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/constant.dart';

class MobileCustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Widget ?suffixIcon;
  final bool isCenter;
  final bool isSecure;
  const MobileCustomTextField(
      {super.key, required this.controller, required this.label, this.suffixIcon, required this.isCenter, required this.isSecure});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Material(
        borderRadius: BorderRadius.circular(12.6.r),
        shadowColor: Colors.black,
        elevation: 4,
        child: TextFormField(
          style: TextStyle(
              fontSize: 12.sp
          ),
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
                    fontSize: 10.sp),
                focusColor: Colors.blue,
                enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.6.r),
                  borderSide: BorderSide(width: 0.58.w,color: Colors.black.withOpacity(.20)),
                ),
                focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(width: 0.58.w,color: Colors.black.withOpacity(.20)),
                ),
                floatingLabelStyle: const TextStyle(color: Colors.blue)),
            cursorColor: kPrimaryColor,
            obscureText: isSecure,
        ),
      ),
    );
  }
}
