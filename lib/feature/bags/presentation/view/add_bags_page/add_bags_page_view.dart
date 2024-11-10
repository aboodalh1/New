import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrreader/feature/bags/presentation/manger/bags_cubit.dart';
import 'package:qrreader/feature/bags/presentation/view/add_bags_page/mobile_add_bags_page.dart';
import 'package:qrreader/feature/bags/presentation/view/add_bags_page/tablet_add_bags_page.dart';

import '../../../../../core/util/screen_util.dart';
import 'desktop_add_bags_page.dart';


class AddBagsPageView extends StatelessWidget {
  const AddBagsPageView({super.key, required this.bagsCubit});
  final BagsCubit bagsCubit;
  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return LayoutBuilder(builder: (context,constraints){
      if (ScreenSizeUtil.screenWidth <= 600) {
        return BlocProvider.value(
          value: bagsCubit,
          child: const MobileAddBagsPage(),
        );
      }
      if (ScreenSizeUtil.screenWidth <= 1000) {
        return BlocProvider.value(
          value: bagsCubit,
          child:  const TabletAddBagsPage(),
        );
      } else {
        return BlocProvider.value(
          value: bagsCubit,
          child:  DesktopAddBagsPage(bagsCubit: bagsCubit,),
        );

      }
    });
  }
}
