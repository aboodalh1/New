import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/util/function/navigation.dart';
import 'package:qrreader/core/util/screen_util.dart';
import 'package:qrreader/feature/bags/presentation/manger/bags_cubit.dart';
import 'package:qrreader/feature/bags/presentation/view/add_bags_page/add_bags_page_view.dart';
import 'package:qrreader/feature/home_page/presentation/view/widgets/custom_elevated_button.dart';

import '../../../../constant.dart';
import '../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../../../core/widgets/desktop/desktop_custom_loading_indicator.dart';
import '../widgets/bags_item.dart';

class DesktopBagsPage extends StatelessWidget {
  const DesktopBagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return BlocConsumer<BagsCubit, BagsState>(
      listener: (context, state) {
        if (state is GetBagsNumberFailure) {
          customSnackBar(context, state.error,duration: 10,color: kOnWayColor);
        }
        if (state is ChangeBagsStateFailure) {
          customSnackBar(context, state.error,duration: 10,color: kOnWayColor);
        }
        if(state is ChangeBagsStateSuccess){
          customSnackBar(context, 'State changed successfully',duration: 12);
        }
      },
      builder: (context, state) {
        if (state is GetBagsNumberLoading || state is ChangeBagsStateLoading) {return const DesktopLoadingIndicator();}
        final BagsCubit bagsCubit = context.read<BagsCubit>();
        return Scaffold(
            body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 38.0, right: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      width: 98.w,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: kPrimaryColor, width: 0.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                bagsCubit.getAllBags(state: 'all');
                              },
                              child: Container(
                                height: 40,
                                width: 32.w,
                                decoration: BoxDecoration(
                                  color: !bagsCubit.isAvailable && !bagsCubit.isUnavailable? kSecondaryColor:null,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.r),
                                      bottomLeft: Radius.circular(15.r)),
                                ),
                                child: Center(
                                  child: Text(
                                    "All",
                                    style: TextStyle(
                                        color: !bagsCubit.isAvailable &&
                                                !bagsCubit.isUnavailable
                                            ? Colors.white
                                            : kSecondaryColor,
                                        fontSize: 4.sp),
                                  ),
                                ),
                              )),
                          VerticalDivider(
                            width: 1.w,
                            color: kPrimaryColor,
                          ),
                          GestureDetector(
                              onTap: () {
                                bagsCubit.getAllBags(state: 'available');
                              },
                              child: Container(
                                height: 40,
                                width: 31.w,
                                decoration: BoxDecoration(
                                    color: bagsCubit.isAvailable
                                        ? kSecondaryColor
                                        : null),
                                child: Center(
                                  child: Text(
                                    "Available",
                                    style: TextStyle(
                                        color: bagsCubit.isAvailable
                                            ? Colors.white
                                            : kSecondaryColor,
                                        fontSize: 4.sp),
                                  ),
                                ),
                              )),
                          VerticalDivider(
                            width: 1.w,
                            color: kUnsubsicriber,
                          ),
                          GestureDetector(
                              onTap: () {
                                bagsCubit.getAllBags(state: 'unavailable');
                              },
                              child: Container(
                                height: 40,
                                width: 32.4.w,
                                decoration: BoxDecoration(
                                  color: bagsCubit.isUnavailable
                                      ? kUnsubsicriber
                                      : null,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15.r),
                                      bottomRight: Radius.circular(15.r)),
                                ),
                                child: Center(
                                  child: Text(
                                    "Unavailable",
                                    style: TextStyle(
                                        color: bagsCubit.isUnavailable
                                            ? Colors.white
                                            : kUnsubsicriber,
                                        fontSize: 3.5.sp),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                        width: 50.w,
                        height: 35,
                        child: CustomElevatedButton(
                            platform: 'desktop',
                            title: 'Edit bags number',
                            onPressed: () {
                              navigateTo(
                                  context,
                                  AddBagsPageView(
                                    bagsCubit: bagsCubit,
                                  ));
                            },
                            fill: true))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    child: GridView.builder(
                      itemCount: bagsCubit.allBagsModel.data.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5, mainAxisExtent: 200),
                      itemBuilder: (context, index) =>
                          AvailableBagsItem(bagsCubit: bagsCubit, index: index),
                    ))
              ],
            ),
          ),
        ));
      },
    );
  }
}
