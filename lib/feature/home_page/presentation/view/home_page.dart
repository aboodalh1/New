import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrreader/feature/customers/presentation/manger/customer_cubit.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/manger/qrs_list_to_download_cubit.dart';
import 'package:qrreader/feature/home_page/presentation/view/desktop_home_page.dart';
import 'package:qrreader/feature/home_page/presentation/view/mobile_home_page.dart';
import 'package:qrreader/feature/home_page/presentation/view/tablet_home_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return BlocListener<CustomerCubit, CustomerState>(
      listener: (context, state) {},
      child: LayoutBuilder(builder: (context, constraints) {
        if (mediaQueryData.size.width <= 600) {
          return const MobileHomePage();
        }
        if (mediaQueryData.size.width <= 1000) {
          return const TabletHomePage();
        } else {
          return BlocProvider.value(
            value: BlocProvider.of<QrsListToDownloadCubit>(context),
            child: const DesktopHomePage());
        }
      }),
    );
  }
}
