import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrreader/feature/users/presentation/manger/user_cubit.dart';
import 'package:qrreader/feature/users/presentation/view/add_user/desktop_add_user_page.dart';
import 'package:qrreader/feature/users/presentation/view/add_user/mobile_add_user_page.dart';
import 'package:qrreader/feature/users/presentation/view/add_user/tablet_add_user_page.dart';

import '../../../../../core/util/screen_util.dart';


class AddUserPageView extends StatelessWidget {
  const AddUserPageView({super.key, required this.userCubit, required this.isEdit});
  final UserCubit userCubit;
  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return LayoutBuilder(builder: (context,constraints){
      if (ScreenSizeUtil.screenWidth <= 600) {
        return BlocProvider.value(
          value: userCubit,
          child: const MobileAddUserPage(),
        );
      }
      if (ScreenSizeUtil.screenWidth <= 1000) {
        return BlocProvider.value(
          value: userCubit,
          child:   TabletAddUserPage(isEdit: isEdit,),
        );
      } else {
        return BlocProvider.value(
          value: userCubit,
          child:   DesktopAddUserPage(isEdit: isEdit,),
        );

      }
    });
  }
}
