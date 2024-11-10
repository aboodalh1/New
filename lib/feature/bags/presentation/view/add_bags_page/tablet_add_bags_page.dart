import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/feature/bags/presentation/manger/bags_cubit.dart';
import '../../../../../constant.dart';
import '../../../../../core/util/asset_loader.dart';
import '../../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../widgets/custom_add_bags_button.dart';

class TabletAddBagsPage extends StatelessWidget {
  const TabletAddBagsPage({super.key});

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
        if(state is EditBagsNumberLoading ){
          return Scaffold(
            body: Center(child: Container(
              decoration: BoxDecoration(color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10.r)
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              width: 100.w,height: 200.h,child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Loding...",style: TextStyle(fontSize: 10.sp,color: const Color(0xffFFFFFF)),),
                SizedBox(height: 20.h,),
                const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),),),
          );}
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
                              IconButton(
                                  onPressed: () {
                                    bagsCubit.decreaseBagsCounter();
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_left,
                                    size: 8.sp,
                                  )),
                              SizedBox(
                                  width: 20.w,
                                  child: TextField(
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        color: kPrimaryColor),
                                    cursorColor: kPrimaryColor,
                                    controller:
                                        bagsCubit.bagsController,
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(4),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: const InputDecoration(
                                      hoverColor: kPrimaryColor,
                                      border: InputBorder.none,
                                    ),
                                  )),
                              IconButton(
                                  onPressed: () {
                                    bagsCubit.increaseBagsCounter();
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 8.sp,
                                  ))
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
                          width: 80.w,
                          child: CustomAddBagsButton(
                            fontSize: 8.sp,
                              title: 'Done',
                              onPressed: (){
                                bagsCubit.editBagsNumber(number: int.parse(bagsCubit.bagsController.text));
                              },
                              doneOrCancel: true)),
                      const Spacer(),
                      SizedBox(
                          width: 80.w,
                          child: CustomAddBagsButton(
                            fontSize: 8.sp,
                            title: 'Cancel',
                            onPressed: () {
                              bagsCubit.bagsController.text = bagsCubit.allBagsModel.data.length.toString();
                              Navigator.of(context).pop();
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
