import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/util/asset_loader.dart';
import 'package:qrreader/core/util/screen_util.dart';
import 'package:qrreader/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:qrreader/dashboard.dart';
import 'package:qrreader/feature/bags/presentation/manger/bags_cubit.dart';
import 'package:qrreader/feature/bags/presentation/widgets/custom_add_bags_button.dart';
import '../../../../../constant.dart';
import '../../../../../core/util/function/navigation.dart';

class DesktopAddBagsPage extends StatelessWidget {
  const DesktopAddBagsPage({super.key, required this.bagsCubit});
  final BagsCubit bagsCubit;
  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Bags Number'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              navigateAndFinish(context, const DashboardPage(startRoute: 'bags',));
            },
          ),
        ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width:150.w,
            height: 360.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.43),
              border: Border.all(color: kPrimaryColor, width: 3),
            ),
            padding: EdgeInsets.symmetric(vertical: 30.h ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetsLoader.bags,width: 160.w,height: 160.h,),
                SizedBox(height: 15.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Quantity',style: TextStyle(color: kPrimaryColor,fontSize: 8.sp,),),
                    SizedBox(width: 20.h,),
                    Column(
                      children: [
                        IconButton(onPressed: (){
                          bagsCubit.increaseBagsCounter();
                        }, icon: Icon(Icons.keyboard_arrow_up,size: 5.sp,)),
                        SizedBox(width:20.w,child: TextField(
                          style: TextStyle(fontSize: 6.sp,color: kPrimaryColor),
                          cursorColor: kPrimaryColor,
                          controller: bagsCubit.bagsController,
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
                        IconButton(onPressed: (){
                          bagsCubit.decreaseBagsCounter();
                        }, icon: Icon(Icons.keyboard_arrow_down,size: 5.sp,))
                      ],
                    )
                  ]

                )
              ]
            ),
          ),
          SizedBox(height: 10.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 105.w),
            child: Row(
              children: [
                SizedBox(
                    width:50.w,
                    child: CustomAddBagsButton(
                        fontSize: 5.sp,
                        title: 'Done', onPressed: (){
                      bagsCubit.editBagsNumber(number: int.parse(bagsCubit.bagsController.text));
                    }, doneOrCancel: true)),
                const Spacer(),
                SizedBox(
                    width:50.w,
                    child: CustomAddBagsButton(
                      fontSize: 5.sp,
                      title: 'Cancel', onPressed: (){
                      Navigator.of(context).pop();
                    }, doneOrCancel: false, )),
              ],
            ),
          )
        ],
      )
    );
  },
);
  }
}