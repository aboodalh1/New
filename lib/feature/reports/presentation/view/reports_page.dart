import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrreader/feature/reports/presentation/manger/reports_cubit.dart';
import 'package:qrreader/feature/reports/presentation/view/desktop_reports_page.dart';
import 'package:qrreader/feature/reports/presentation/view/mobile_reports_page.dart';
import 'package:qrreader/feature/reports/presentation/view/tablet_reports_page.dart';

import '../../../../core/util/screen_util.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return LayoutBuilder(builder: (context, constraints) {
      if (ScreenSizeUtil.screenWidth <= 600) {
        return BlocProvider.value(
          value: context.read<ReportsCubit>(),
          child: const MobileReportsPage(),
        );
      }
      if (ScreenSizeUtil.screenWidth <= 1000) {
        return BlocProvider.value(
          value: context.read<ReportsCubit>(),
          child: const TabletReportsPage(),
        );
      } else {
        return BlocProvider.value(
          value: context.read<ReportsCubit>(),
          child: const DesktopReportsPage(),
        );

      }
    });
  }
}
