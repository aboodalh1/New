import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../constant.dart';

class TabletLoadingIndicator extends StatelessWidget {
  const TabletLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          width: 100.w,
          height: 200.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Fetching Data",
                style:
                    TextStyle(fontSize: 10.sp, color: const Color(0xffFFFFFF)),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 30.h,
                width: 30.w,
                child: const LoadingIndicator(
                  indicatorType: Indicator.lineScale,
                  colors: [Color(0xffFFFFFF)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
