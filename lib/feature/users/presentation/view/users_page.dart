import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/constant.dart';
import 'package:qrreader/feature/users/presentation/view/desktop_user_page.dart';
import 'package:qrreader/feature/users/presentation/view/mobile_users_page.dart';
import 'package:qrreader/feature/users/presentation/view/tablet_users_page.dart';

import '../../../../core/util/screen_util.dart';
import '../manger/user_cubit.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({
    super.key,
  });

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().rows = [];
    for (int i = 0;
        i < context.read<UserCubit>().allUsersModel.data.length;
        i++) {
      if (context.read<UserCubit>().allUsersModel.data[i].id == 1) continue;
      if (context.read<UserCubit>().allUsersModel.data[i].id ==
          context.read<UserCubit>().currentUser) {
        context.read<UserCubit>().rows.add(DataRow(cells: [
              DataCell(Row(
                children: [
                  Text(context.read<UserCubit>().allUsersModel.data[i].name),
                  Icon(
                    Icons.person,
                    color: kPrimaryColor,
                    size: 10.sp,
                  )
                ],
              )),
              DataCell(
                  Text(context.read<UserCubit>().allUsersModel.data[i].phone)),
              DataCell(
                  Text(context.read<UserCubit>().allUsersModel.data[i].role)),
              DataCell(Row(
                children: [
                  CustomEditTextButton(
                    userCubit: context.read<UserCubit>(),
                    i: i,
                    isTablet: false,
                  ),
                  CustomDeleteTextButton(
                    userCubit: context.read<UserCubit>(),
                    i: i,
                    isTablet: false,
                  ),
                ],
              )),
            ]));
      } else {
        context.read<UserCubit>().rows.add(DataRow(cells: [
              DataCell(
                  Text(context.read<UserCubit>().allUsersModel.data[i].name)),
              DataCell(
                  Text(context.read<UserCubit>().allUsersModel.data[i].phone)),
              DataCell(
                  Text(context.read<UserCubit>().allUsersModel.data[i].role)),
              DataCell(Row(
                children: [
                  CustomDeleteTextButton(
                    userCubit: context.read<UserCubit>(),
                    i: i,
                    isTablet: false,
                  ),
                  CustomEditTextButton(
                    userCubit: context.read<UserCubit>(),
                    i: i,
                    isTablet: false,
                  )
                ],
              )),
            ]));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return LayoutBuilder(builder: (context, constraints) {
      if (ScreenSizeUtil.screenWidth <= 600) {
        return BlocProvider.value(
          value: context.read<UserCubit>(),
          child: const MobileUsersPage(),
        );
      }
      if (ScreenSizeUtil.screenWidth <= 1000) {
        return BlocProvider.value(
          value: context.read<UserCubit>(),
          child: const TabletUsersPage(),
        );
      } else {
        return BlocProvider.value(
          value: context.read<UserCubit>(),
          child: const DesktopUsersPage(),
        );
      }
    });
  }
}
