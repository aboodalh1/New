import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrreader/core/util/service_locator.dart';
import 'package:qrreader/feature/bags/data/repos/bags_repo_impl.dart';
import 'package:qrreader/feature/bags/presentation/manger/bags_cubit.dart';
import 'package:qrreader/feature/bags/presentation/view/desktop_bags_page.dart';
import 'package:qrreader/feature/bags/presentation/view/mobile_bags_page.dart';
import 'package:qrreader/feature/bags/presentation/view/tablet_bags_page.dart';

import '../../../../core/util/screen_util.dart';

class BagsPageView extends StatelessWidget {
  const BagsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return BlocProvider(
      create: (context) => BagsCubit(getIt.get<BagsRepoImpl>())..getAllBags(state: 'all'),
      child: LayoutBuilder(builder: (context, constraints) {
        if (ScreenSizeUtil.screenWidth <= 600) {
          return BlocProvider.value(
            value: context.read<BagsCubit>(),
            child: const MobileBagsPage(),
          );
        }
        if (ScreenSizeUtil.screenWidth <= 1000) {
          return BlocProvider.value(
            value: context.read<BagsCubit>(),
            child: const TabletBagsPage(),
          );
        } else {
          return BlocProvider.value(
            value: context.read<BagsCubit>(),
            child: const DesktopBagsPage(),
          );
        }
      }),
    );
  }
}
