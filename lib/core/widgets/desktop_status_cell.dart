import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesktopStatusCell extends StatelessWidget {
  const DesktopStatusCell({
    super.key, required this.title, required this.color,
  });
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.w,
      height: 25,
      padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3)
      ),
      child: Text(
          textAlign: TextAlign.center,
          title,
          style: TextStyle(
              fontSize: 3.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black)),
    );
  }
}