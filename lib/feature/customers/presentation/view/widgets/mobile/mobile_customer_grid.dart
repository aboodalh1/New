import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/util/screen_util.dart';
import 'package:qrreader/feature/customers/presentation/manger/customer_cubit.dart';
import 'mobile_add_customer_info_card.dart';
import 'mobile_customer_card.dart';

class MobileCustomerGrid extends StatelessWidget {
  const MobileCustomerGrid({
    super.key, required this.customerCubit,
  });
  final CustomerCubit customerCubit;
  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return BlocConsumer<CustomerCubit, CustomerState>(
  listener: (context, state) {},
  builder: (context, state) {
    CustomerCubit customerCubit = context.read<CustomerCubit>();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: customerCubit.allCustomersModel.data.length+1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.w,
          mainAxisExtent: 280
          ),
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index) =>
      index == 0 ? MobileAddCustomerInformationCard(customerCubit: customerCubit,) : MobileCustomerCard(customerCubit: customerCubit, index: index-1,),
    );
  },
);
  }
}

