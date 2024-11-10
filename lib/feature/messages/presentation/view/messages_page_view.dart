import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrreader/core/util/service_locator.dart';
import 'package:qrreader/feature/messages/presentation/view/desktop_messages_page.dart';
import 'package:qrreader/feature/messages/presentation/view/mobile_mssages_page.dart';
import 'package:qrreader/feature/messages/presentation/view/tablet_messages_page.dart';

import '../../../../core/util/screen_util.dart';
import '../../data/repos/messages_repo_impl.dart';
import '../manger/messages_cubit.dart';

class MessagePageView extends StatelessWidget {
  const MessagePageView({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return BlocProvider(
      create: (context) => MessagesCubit(getIt.get<MessagesRepoImpl>())..getAllMessages()..getAllUnverified(),
      child: LayoutBuilder(builder: (context, constraints) {
        if (ScreenSizeUtil.screenWidth <= 600) {
          return BlocProvider.value(
            value: context.read<MessagesCubit>(),
            child: const MobileMessagesPage(),
          );
        }
        if (ScreenSizeUtil.screenWidth <= 1000) {
          return BlocProvider.value(
            value: context.read<MessagesCubit>(),
            child: const TabletMessagesPage(),
          );
        } else {
          return BlocProvider.value(
            value: context.read<MessagesCubit>(),
            child: const DesktopMessagesPage(),
          );
        }
      }),
    );
  }
}