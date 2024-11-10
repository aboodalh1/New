import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/feature/customers/presentation/manger/customer_cubit.dart';
import 'package:qrreader/feature/customers/presentation/view/widgets/new_customer_card.dart';
import 'customer_card.dart';

class CustomerGrid extends StatelessWidget {
  const CustomerGrid({
    super.key,
    required this.customerCubit,
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
          itemCount: customerCubit.allCustomersModel.data.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 20.h,
            childAspectRatio: 1.6.w / 8.h,
          ),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
          itemBuilder: (context, index) => index == 0
              ? NewCustomerCard(
                  isEdit: state is AddCustomersFailure ? true : false,
                  customerCubit: customerCubit,
                )
              : CustomerCard(customerCubit: customerCubit, index: index - 1),
        );
      },
    );
  }
}
