import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MobileCustomText extends StatelessWidget {
  const MobileCustomText({
    super.key,
    required this.title,
    required this.isHeader,
  });

  final String title;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45.w,
      child: Text(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        title,
        style: TextStyle(
            fontWeight: isHeader? FontWeight.w400:FontWeight.w300,
            color: isHeader ? Colors.white : Colors.black,
            fontSize: 5.5.sp),
      ),
    );
  }
}
