import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabletCustomColumnText extends StatelessWidget {
  const TabletCustomColumnText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
        textAlign: TextAlign.center,
        title,
        style: TextStyle(
            fontSize: 6.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white));
  }
}
class TabletCustomRowText extends StatelessWidget {
  const TabletCustomRowText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
        textAlign: TextAlign.center,
        title,
        style: TextStyle(
            fontSize: 6.sp,
            fontWeight: FontWeight.w300,
            color: Colors.black));
  }
}
