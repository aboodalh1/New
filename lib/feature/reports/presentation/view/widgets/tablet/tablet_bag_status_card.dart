import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../constant.dart';

class TabletBagsStatusCard extends StatelessWidget {
  const TabletBagsStatusCard({
    super.key, required this.image, required this.bagsNumber, required this.title, required this.platform,
  });
  final String image;
  final String bagsNumber;
  final String title;
  final String platform;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: const Border(
              left: BorderSide(color: kPrimaryColor,width: 1),
              top:BorderSide(color: kPrimaryColor,width: 1),
              right: BorderSide(color: kPrimaryColor,width: 10),
              bottom: BorderSide(color: kPrimaryColor,width: 1)
          )
      ),
      height: platform=='mobile'?120:150,
      width: 90.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(image,height: 80,width: 20.w,),
              SizedBox(width: 3.w,),
              Text(title,style: TextStyle(fontSize: 7.sp),)
            ],
          ),
        platform!='mobile'?  SizedBox(height: 10.h,):const SizedBox(),
          Padding(
            padding: EdgeInsets.only(left: 4.0.w),
            child: Row(
              children: [
                Text(bagsNumber,style: TextStyle(fontSize: platform=="mobile"?10.sp:6.sp),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
