import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrreader/core/util/screen_util.dart';
import 'package:qrreader/core/util/service_locator.dart';
import 'package:qrreader/feature/generate_qr_code/data/repos/generate_qr_repo_impl.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/manger/generate_qr_cubit.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/view/desktop_generate_qr_page.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/view/mobile_generate_qr_page.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/view/tablet_generate_qr_page.dart';

class GenerateQrPageViw extends StatelessWidget {
  const GenerateQrPageViw({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return BlocProvider(
      create: (context) => GenerateQrCubit(getIt.get<GenerateQrRepoImpl>()),
      child: LayoutBuilder(builder: (context, constraints) {
        if (ScreenSizeUtil.screenWidth <= 600) {
          return BlocProvider.value(
            value:context.read<GenerateQrCubit>(),
            child: const MobileGenerateQRPage(),
          );
        }
        if (ScreenSizeUtil.screenWidth <= 1000) {
          return BlocProvider.value(
            value:context.read<GenerateQrCubit>(),
            child: const TabletGenerateQrPage(),
          );
        } else {
          return BlocProvider.value(
            value:context.read<GenerateQrCubit>(),
            child: const DesktopGenerateQRPage(),
          );
        }
      }),
    );
  }
}
