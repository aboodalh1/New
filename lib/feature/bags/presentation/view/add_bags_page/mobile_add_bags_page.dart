import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constant.dart';
import '../../../../../core/util/asset_loader.dart';
import '../../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../manger/bags_cubit.dart';
import '../../widgets/custom_add_bags_button.dart';

class MobileAddBagsPage extends StatelessWidget {
  const MobileAddBagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BagsCubit, BagsState>(
      listener: (context, state) {
        if(state is EditBagsNumberFailure){
          customSnackBar(context, state.error,color: kOnWayColor);
        }
        if(state is EditBagsNumberSuccess){
          if(state.message.contains('You Need To Detach')){
            customSnackBar(context, state.message,color: kOnWayColor,duration: 2000);
          }
          else{
            customSnackBar(context, state.message);
            if(Navigator.of(context).canPop()){
              Navigator.of(context).pop();
            }}
        }
      },
      builder: (context, state) {
        if(state is EditBagsNumberLoading){
          return const Center(child: SizedBox(width: 100,height: 100,child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),),);
        }
        BagsCubit bagsCubit = context.read<BagsCubit>();
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Edit Bags Number",
              ),
              backgroundColor: kPrimaryColor,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200.w,
                  height: 360.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.43),
                    border: Border.all(color: kPrimaryColor, width: 3),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetsLoader.bags,
                          width: 160.w,
                          height: 160.h,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Quantity',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 8.sp,
                                ),
                              ),
                              SizedBox(
                                width: 20.h,
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        bagsCubit.increaseBagsCounter();
                                      },
                                      icon: Icon(
                                        Icons.keyboard_arrow_up,
                                        size: 15.sp,
                                      )),
                                  SizedBox(
                                      height: 40.h,
                                      width: 45.w,
                                      child: TextField(
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: kPrimaryColor),
                                        cursorColor: kPrimaryColor,
                                        controller: bagsCubit.bagsController,
                                        textAlign: TextAlign.center,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(4),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          hoverColor: kPrimaryColor,
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 15.h, horizontal: 5.w),
                                        ),
                                      )),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        bagsCubit.decreaseBagsCounter();
                                      },
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 15.sp,
                                      ))
                                ],
                              )
                            ])
                      ]),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.w),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 70.w,
                          child: CustomAddBagsButton(
                              fontSize: 7.sp,
                              title: 'Done',
                              onPressed: () {
                                bagsCubit.bagsController.text == ''
                                    ? customSnackBar(
                                        context, 'Please Enter Bags Number')
                                : bagsCubit.editBagsNumber(
                                        number: int.parse(
                                            bagsCubit.bagsController.text));
                              },
                              doneOrCancel: true)),
                      const Spacer(),
                      SizedBox(
                          width: 70.w,
                          child: CustomAddBagsButton(
                            fontSize: 7.sp,
                            title: 'Cancel',
                            onPressed: () {
                              if (Navigator.of(context).canPop()) {
                                Navigator.of(context).pop();
                              }
                            },
                            doneOrCancel: false,
                          )),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }
}
