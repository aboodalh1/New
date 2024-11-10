import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/feature/customers/presentation/manger/customer_cubit.dart';

import 'tablet_add_customer_info_card.dart';
import 'tablet_customer_card.dart';

class TabletCustomerGrid extends StatelessWidget {
  const TabletCustomerGrid({
    super.key, required this.customerCubit,
  });
  final CustomerCubit customerCubit;
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CustomerCubit, CustomerState>(
  listener: (context, state) {},
  builder: (context, state) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: customerCubit.allCustomersModel.data.length+1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5.w,
        mainAxisSpacing: 20.h,
        childAspectRatio: 2.w / 7.2.h,
          ),
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index) =>
      index == 0 ?  TabletAddCustomerInformationCard(customerCubit: customerCubit) : TabletCustomerCard(customerCubit: customerCubit,index:index-1),
    );
  },
);
  }
}

