import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constant.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    super.key, required this.title, required this.onPressed,  required this.fill, this.platform,
  });
  final String title;
  final bool fill;
  final VoidCallback onPressed;
   String? platform='desktop';
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.25)),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 5.w,vertical: 4.h)),
          backgroundColor: MaterialStateProperty.all(fill?kSecondaryColor: const Color(0xffFFFFFF)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: !fill?const BorderSide(width: 1.6,color: kPrimaryColor):BorderSide.none,
              borderRadius: BorderRadius.circular(11.r),
            ),
          )),
      child:  Text(
        title,
        style: TextStyle(
            fontSize: platform=='desktop'?4.sp:7.sp, fontWeight: FontWeight.w300, color: fill?Colors.white:kPrimaryColor),
      ),
    );
  }
}
