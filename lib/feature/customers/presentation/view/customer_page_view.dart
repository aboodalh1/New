import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrreader/core/util/screen_util.dart';
import 'package:qrreader/feature/customers/presentation/manger/customer_cubit.dart';
import 'package:qrreader/feature/customers/presentation/view/desktop_customer_page.dart';
import 'package:qrreader/feature/customers/presentation/view/mobile_customer_page.dart';
import 'package:qrreader/feature/customers/presentation/view/tablet_customer_page.dart';

class CustomerPageView extends StatelessWidget {
  const CustomerPageView({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return LayoutBuilder(builder: (context, constraints) {
      if (ScreenSizeUtil.screenWidth <= 600) {
        return BlocProvider.value(
          value: context.read<CustomerCubit>(),
          child: const MobileCustomerPage(),
        );
      }
      if (ScreenSizeUtil.screenWidth <= 1000) {
        return BlocProvider.value(
          value: context.read<CustomerCubit>(),
          child: const TabletCustomerPage(),
        );
      }
      return BlocProvider.value(
        value: context.read<CustomerCubit>(),
        child: const DesktopCustomerPage(),
      );
    }
    );
  }
}
