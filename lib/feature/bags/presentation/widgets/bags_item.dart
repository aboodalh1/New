import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/feature/bags/presentation/manger/bags_cubit.dart';

import '../../../../constant.dart';
import '../../../../core/util/asset_loader.dart';

class AvailableBagsItem extends StatelessWidget {
  const AvailableBagsItem({
    super.key, required this.bagsCubit, required this.index, required this.isDesktop,
  });
  final BagsCubit bagsCubit;
  final int index;
  final bool isDesktop;
  @override
  Widget build(BuildContext context) {
    return bagsCubit.allBagsModel.data[index].isAvailable?Column(
      children: [
        Image.asset(AssetsLoader.availableBag),
        const SizedBox(height: 5,),
        Text('ID: ${bagsCubit.allBagsModel.data[index].id} \n Available',textAlign: TextAlign.center,style: const TextStyle(color: kPrimaryColor),),
      ],
    ):UnAvailableBagsItem(bagsCubit: bagsCubit,index: index,isDesktop: isDesktop,);
  }
}

class UnAvailableBagsItem extends StatelessWidget {
  const UnAvailableBagsItem({
    super.key, required this.bagsCubit, required this.index, required this.isDesktop,
  });
 final BagsCubit bagsCubit;
 final int index;
 final bool isDesktop;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(onPressed: (){
          showDialog(context: context, builder: (context)=>AlertDialog(
            backgroundColor: Colors.white,
            content: Text("Are you sure ? \nthe bag which id is ${bagsCubit.allBagsModel.data[index].id} will change its state",
            style: TextStyle(fontSize: isDesktop?4.5.sp:8.sp,color: Colors.black),
            ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize:isDesktop?4.sp: 12.sp,
                          color: Colors.black),
                    )),
                     TextButton(
                        onPressed: () async {
                          await bagsCubit.changeBagsState(id: bagsCubit.allBagsModel.data[index].id);
                        },
                        child: Text(
                          "Change",
                          style: TextStyle(
                              color: kUnsubsicriber,
                              fontSize: isDesktop?4.sp:12.sp),
                        )),

            ],
          ));
        }, child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Change state",style: TextStyle(color: kUnsubsicriber,fontSize: isDesktop? 4.5.sp:6.sp),),
            const Icon(Icons.forward_5_rounded,color: kUnsubsicriber,),
          ],
        )),
        Image.asset(AssetsLoader.unAvailableBag),
        const SizedBox(height: 10,),
         Text('ID: ${bagsCubit.allBagsModel.data[index].id} \n Unavailable',textAlign: TextAlign.center,style: const TextStyle(color: kUnsubsicriber),),
      ],
    );
  }
}
