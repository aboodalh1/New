import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/util/function/navigation.dart';
import 'package:qrreader/core/util/screen_util.dart';
import 'package:qrreader/core/widgets/tablet/tablet_custom_loading_indicator.dart';
import 'package:qrreader/feature/bags/presentation/manger/bags_cubit.dart';
import 'package:qrreader/feature/bags/presentation/view/add_bags_page/add_bags_page_view.dart';
import '../../../../constant.dart';
import '../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../../home_page/presentation/view/widgets/custom_elevated_button.dart';
import '../widgets/bags_item.dart';

class TabletBagsPage extends StatelessWidget {
  const TabletBagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return BlocConsumer<BagsCubit, BagsState>(
      listener: (context, state) {
        if (state is GetBagsNumberFailure) {
          customSnackBar(context, state.error,color: kOnWayColor);
        } if (state is ChangeBagsStateFailure) {
          customSnackBar(context, state.error,duration: 10,color: kOnWayColor);
        }
        if(state is ChangeBagsStateSuccess){
          customSnackBar(context, 'State changed successfully',duration: 12);
        }
      },
      builder: (context, state) {
        if (state is GetBagsNumberLoading ||  state is ChangeBagsStateLoading) {
       return const TabletLoadingIndicator();
        }
        BagsCubit bagsCubit = context.read<BagsCubit>();
        return Scaffold(
            body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(top: 38.0.h, right: 20.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      width: 125.w,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: kPrimaryColor, width: 0.5)),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                bagsCubit.getAllBags(state: 'all');
                              },
                              child: Container(
                                  height: 40,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                    color: !bagsCubit.isAvailable && !bagsCubit.isUnavailable? kSecondaryColor:null,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.r),
                                        bottomLeft: Radius.circular(15.r))),
                                child: Center(
                                  child: Text(
                                    "All",
                                    style: TextStyle(
                                        color: !bagsCubit.isAvailable &&
                                            !bagsCubit.isUnavailable
                                            ? Colors.white
                                            : kSecondaryColor, fontSize: 5.sp),
                                  ),
                                ),
                              )),
                          const Spacer(),
                          const VerticalDivider(
                            width: 2,
                            color: kPrimaryColor,
                          ),
                          const Spacer(),
                          GestureDetector(
                              onTap: () {
                                bagsCubit.getAllBags(state: 'available');
                              },
                              child: Container(
                                height: 40,
                                width: 40.w,
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
                                            : kSecondaryColor, fontSize: 5.sp),
                                  ),
                                ),
                              )),
                          const Spacer(),
                          const VerticalDivider(
                            width: 2,
                            color: kUnsubsicriber,
                          ),
                          const Spacer(),
                          GestureDetector(
                              onTap: () {
                                bagsCubit.getAllBags(state: 'unavailable');
                              },
                              child: Container(
                                height: 40,
                                width: 42.w,
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
                                        color:  bagsCubit.isUnavailable
                                            ? Colors.white
                                            : kUnsubsicriber, fontSize: 5.sp),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                        width: 80.w,
                        child: CustomElevatedButton(
                            platform: 'tablet',
                            title: 'Edit bags number',
                            onPressed: () {
                              navigateTo(context,
                                  AddBagsPageView(bagsCubit: bagsCubit));
                            },
                            fill: true))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bagsCubit.allBagsModel.data.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, mainAxisExtent: 200),
                    itemBuilder: (context, index) => AvailableBagsItem(
                      isDesktop: false,
                          bagsCubit: bagsCubit,
                          index: index,
                        ))
              ],
            ),
          ),
        ));
      },
    );
  }
}
