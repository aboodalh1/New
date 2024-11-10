import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleOnImage extends StatelessWidget {
  const TitleOnImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40.h,
      child: Center(
        child: Column(
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              'Hi, enter your details to get sign in into your account',
              style: TextStyle(
                  fontSize: 6.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
