import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:qrreader/feature/customers/presentation/manger/customer_cubit.dart';
import 'package:qrreader/feature/customers/presentation/view/widgets/tablet/tablet_custom_underline_field.dart';
import 'package:qrreader/feature/home_page/presentation/view/widgets/custom_elevated_button.dart';

import '../../../../../../constant.dart';

class TabletAddCustomerInformationCard extends StatefulWidget {
  const TabletAddCustomerInformationCard(
      {super.key, required this.customerCubit});

  final CustomerCubit customerCubit;

  @override
  State<TabletAddCustomerInformationCard> createState() =>
      _TabletAddCustomerInformationCardState();
}

class _TabletAddCustomerInformationCardState
    extends State<TabletAddCustomerInformationCard> {
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return isEdit
        ? BlocListener<CustomerCubit, CustomerState>(
            listener: (context, state) {
              if (state is AddCustomersSuccess) {
                isEdit = !isEdit;
              }
            },
            child: Container(
              height: 440.h,
              width: 390.w,
              padding: EdgeInsets.only(
                  right: 5.w, left: 5.w, top: 10.h, bottom: 10.h),
              margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(14.83)),
                  border: Border.all(width: 2, color: kPrimaryColor),
                  color: Colors.white),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isEdit = !isEdit;
                            });
                          },
                          icon: const Icon(Icons.cancel)),
                      const Spacer(),
                      SizedBox(
                        height: 20.h,
                        width: 25.w,
                        child: CustomElevatedButton(
                            platform: 'desktop',
                            title: 'Add',
                            onPressed: () async {
                              try {
                                await widget.customerCubit.addCustomers(context,
                                    name: widget
                                        .customerCubit.newNameController.text,
                                    phoneNumber: widget.customerCubit
                                        .newPhoneNumberController.text,
                                    location: widget.customerCubit
                                        .newLocationController.text);
                              } catch (e) {
                                customSnackBar(context, e.toString());
                              }
                            },
                            fill: true),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.person,
                    size: 16.sp,
                  ),
                  TabletCustomUnderLineTextField(
                    hint: 'Full name',
                    controller: widget.customerCubit.newNameController,
                  ),
                  TabletCustomUnderLineTextField(
                    hint: 'Customer Num',
                    controller: widget.customerCubit.newPhoneNumberController,
                  ),
                  SizedBox(
                    height: 40,
                    width: 55.w,
                    child: DropdownButtonFormField(
                        iconSize: 10.sp,
                        hint: Text(
                          'Select Driver',
                          style: TextStyle(fontSize: 5.sp),
                        ),
                        isExpanded: true,
                        items:  drivers.sublist(1, drivers.length)
                            .map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          widget.customerCubit.newDriver = val!;
                        }),
                  ),
                  TabletCustomUnderLineTextField(
                    controller: widget.customerCubit.newLocationController,
                    hint: 'Address',
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: 30.w,
                    height: 25.h,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await widget.customerCubit.addCustomers(context,
                              name: widget.customerCubit.newNameController.text,
                              phoneNumber: widget
                                  .customerCubit.newPhoneNumberController.text,
                              location: widget
                                  .customerCubit.newLocationController.text);
                        } catch (e) {
                          customSnackBar(context, e.toString());
                        }
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          backgroundColor:
                              MaterialStateProperty.all(kUnsubsicriber)),
                      child: Text(
                        'Add',
                        style: TextStyle(
                            fontSize: 3.5.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : Container(
            height: 440,
            width: 390.w,
            padding:
                EdgeInsets.only(right: 5.w, left: 5.w, top: 20.h, bottom: 10.h),
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(14.83)),
                border: Border.all(color: kPrimaryColor, width: 2),
                color: Colors.white),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: kSecondaryColor),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              isEdit = !isEdit;
                            });
                          },
                          icon: Icon(Icons.add,
                              color: Colors.white, size: 15.sp))),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Add a new customer',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 3.sp,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          );
  }
}
