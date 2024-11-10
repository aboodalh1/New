import 'package:flutter/material.dart';
import 'package:qrreader/feature/bags/presentation/manger/bags_cubit.dart';

import '../../../../constant.dart';
import '../../../../core/util/asset_loader.dart';

class AvailableBagsItem extends StatelessWidget {
  const AvailableBagsItem({
    super.key, required this.bagsCubit, required this.index,
  });
  final BagsCubit bagsCubit;
  final int index;
  @override
  Widget build(BuildContext context) {
    return bagsCubit.allBagsModel.data[index].isAvailable?Column(
      children: [
        Image.asset(AssetsLoader.availableBag),
        const SizedBox(height: 5,),
        Text('ID: ${bagsCubit.allBagsModel.data[index].id} \n Available',textAlign: TextAlign.center,style: const TextStyle(color: kPrimaryColor),),
      ],
    ):UnAvailableBagsItem(bagsCubit: bagsCubit,index: index,);
  }
}

class UnAvailableBagsItem extends StatelessWidget {
  const UnAvailableBagsItem({
    super.key, required this.bagsCubit, required this.index,
  });
 final BagsCubit bagsCubit;
 final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(onPressed: (){
          bagsCubit.changeBagsState(id:bagsCubit.allBagsModel.data[index].id);
        }, child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Change state",style: TextStyle(color: kUnsubsicriber),),
            Icon(Icons.forward_5_rounded,color: kUnsubsicriber,),
          ],
        )),
        Image.asset(AssetsLoader.unAvailableBag),
        const SizedBox(height: 10,),
         Text('ID: ${bagsCubit.allBagsModel.data[index].id} \n Unavailable',textAlign: TextAlign.center,style: const TextStyle(color: kUnsubsicriber),),
      ],
    );
  }
}
