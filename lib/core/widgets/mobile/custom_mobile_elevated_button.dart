import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant.dart';

class CustomMobileElevatedButton extends StatelessWidget {
  const CustomMobileElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.fill,
  });

  final String title;
  final bool fill;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h)),
          backgroundColor: MaterialStateProperty.all(
              fill ? kSecondaryColor : const Color(0xffF5F5F5)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: !fill
                  ? const BorderSide(width: 0.6, color: kPrimaryColor)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(fill ? 11.r : 11.r),
            ),
          )),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w300,
            color: fill ? Colors.white : kPrimaryColor),
      ),
    );
  }
}
