import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrreader/core/util/screen_util.dart';
import 'package:qrreader/feature/messages/presentation/view/unverified/desktop_unverified_page.dart';
import 'package:qrreader/feature/messages/presentation/view/unverified/mobile_unverified_page.dart';
import 'package:qrreader/feature/messages/presentation/view/unverified/tablet_unverified_page.dart';

import '../../manger/messages_cubit.dart';


class UnverifiedPageView extends StatelessWidget {
  const UnverifiedPageView({super.key, required this.messagesCubit});
  final MessagesCubit messagesCubit;
  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return BlocProvider.value(
      value: messagesCubit,
      child: LayoutBuilder(builder: (context, constraints) {
        if (ScreenSizeUtil.screenWidth <= 600) {
          return BlocProvider.value(
            value: messagesCubit,
            child: const MobileUnverifiedPage(),
          );
        }
        if (ScreenSizeUtil.screenWidth <= 1000) {
          return BlocProvider.value(
            value: messagesCubit,
            child: const TabletUnVerifiedPage(),
          );
        } else {
          return BlocProvider.value(
            value: messagesCubit,
            child: const DesktopUnVerifiedPage(),
          );
        }
      }),
    );
  }
}