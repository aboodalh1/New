import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../constant.dart';


class MobileCustomElevatedButton extends StatelessWidget {
  const MobileCustomElevatedButton({
    super.key, required this.title, required this.onPressed,  required this.fill
  });
  final String title;
  final bool fill;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 10.w,vertical: 2.h)),
          backgroundColor: MaterialStateProperty.all(fill?kSecondaryColor: const Color(0xffF5F5F5)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: !fill?const BorderSide(width: 0.6,color: kPrimaryColor):BorderSide.none,
              borderRadius: BorderRadius.circular(fill?16.r:11.r),
            ),
          )),
      child:  Text(
        title,
        style: TextStyle(
            fontSize: 12.sp, fontWeight: FontWeight.w300, color: fill?Colors.white:kPrimaryColor),
      ),
    );
  }
}
