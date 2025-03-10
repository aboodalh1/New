import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../constant.dart';
import '../../../manger/customer_cubit.dart';
import 'mobile_custom_underline_field.dart';

class MobileAddCustomerInformationCard extends StatefulWidget {
  const MobileAddCustomerInformationCard(
      {super.key, required this.customerCubit});

  final CustomerCubit customerCubit;

  @override
  State<MobileAddCustomerInformationCard> createState() =>
      _MobileAddCustomerInformationCardState();
}

class _MobileAddCustomerInformationCardState
    extends State<MobileAddCustomerInformationCard> {
  bool isEdit = true;

  @override
  Widget build(BuildContext context) {
    return isEdit
        ? Container(
            width: 140.w,
            height: 220.h,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(14.83)),
                border: Border.all(width: 2.r, color: kPrimaryColor),
                color: Colors.white),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: kSecondaryColor),
                      child: Center(
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                isEdit = !isEdit;
                              });
                            },
                            icon: Icon(Icons.add,
                                color: Colors.white, size: 20.sp)),
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Add a new customer',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          )
        : Container(
            width: 140.w,
            height: 280.h,
            padding:
                EdgeInsets.only(right: 5.w, left: 5.w, top: 10, bottom: 5.h),
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(14.83)),
                border: Border.symmetric(
                    horizontal: BorderSide(
                      width: 2,
                      color: kPrimaryColor,
                    ),
                    vertical: BorderSide(width: 5, color: kPrimaryColor)),
                color: Colors.white),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Icon(
                  Icons.person,
                  size: 20.sp,
                ),
                MobileCustomUnderLineTextField(
                  hint: 'Full name',
                  controller: widget.customerCubit.newNameController, onTap: () {  },
                ),
                MobileCustomUnderLineTextField(
                    hint: 'Customer Num',
                    controller: widget.customerCubit.newPhoneNumberController, onTap: () {  },),
                SizedBox(
                  height: 30,
                  width: 100.w,
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
                    ),
                      iconSize: 10.sp,
                      isExpanded: true,
                      style: TextStyle(fontSize: 10.sp),
                      hint: Text(
                        'Select Driver',
                        style: TextStyle(fontSize: 8.sp),
                      ),
                      items: drivers.length>1? drivers.sublist(1, drivers.length)
                          .map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList():[''].map<DropdownMenuItem<String>>(
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
                MobileCustomUnderLineTextField(
                  controller: widget.customerCubit.newLocationController,
                  hint: 'Address', onTap: () {  },
                ),
                MobileCustomUnderLineTextField(
                  onTap: ()=>widget.customerCubit.selectDate(context),
                  controller: widget.customerCubit.dateController,
                  hint: 'Expired Date',
                ),
                SizedBox(
                  height: 15.h,
                ),
                BlocBuilder<CustomerCubit, CustomerState>(
                  builder: (context, state) {
                    return  state is AddCustomersLoading
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: kSecondaryColor,
                      ),
                    )
                        : SizedBox(
                      height: 15,
                      width: 52.w,
                      child:ElevatedButton(
                              onPressed: () {
                                widget.customerCubit.addCustomers(
                                  context,
                                  name: widget
                                      .customerCubit.newNameController.text,
                                  phoneNumber: widget.customerCubit
                                      .newPhoneNumberController.text,
                                  location: widget
                                      .customerCubit.newLocationController.text,
                                );
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero),
                                  backgroundColor: MaterialStateProperty.all(
                                      kSecondaryColor)),
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    fontSize: 8.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                    );
                  },
                )
              ],
            ),
          );
  }
}
