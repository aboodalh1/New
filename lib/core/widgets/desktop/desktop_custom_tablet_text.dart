import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesktopCustomColumnText extends StatelessWidget {
  const DesktopCustomColumnText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
        textAlign: TextAlign.center,
        title,
        style: TextStyle(
            fontSize: 4.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white));
  }
}

class DesktopCustomRowText extends StatelessWidget {
  const DesktopCustomRowText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      child: Text(
          textAlign: TextAlign.start,
          title,
          style: TextStyle(
              fontSize: 4.sp,
              fontWeight: FontWeight.w300,
              color: Colors.black)),
    );
  }
}
