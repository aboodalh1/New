import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/util/screen_util.dart';
import 'package:qrreader/feature/customers/presentation/manger/customer_cubit.dart';
import 'package:qrreader/feature/customers/presentation/view/widgets/mobile/mobile_custom_underline_field.dart';

import '../../../../../../constant.dart';
import '../../../../../home_page/presentation/view/widgets/custom_elevated_button.dart';

class MobileCustomerCard extends StatefulWidget {
  MobileCustomerCard(
      {super.key, required this.customerCubit, required this.index});

  final int index;
  final CustomerCubit customerCubit;
  final TextEditingController editNameController = TextEditingController();
  final TextEditingController editPhoneNumberController =
      TextEditingController();
  final TextEditingController editLocationController = TextEditingController();
  final TextEditingController editDriverController = TextEditingController();

  @override
  State<MobileCustomerCard> createState() => _MobileCustomerCardState();
}

class _MobileCustomerCardState extends State<MobileCustomerCard> {
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return isEdit
        ? Container(
            width: 140.w,
            padding: EdgeInsets.only(right: 5.w, left: 5.w, top: 10, bottom: 5),
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            isEdit = !isEdit;
                          });
                        },
                        child: Icon(
                          Icons.cancel,
                          size: 15.sp,
                        )),
                    const Spacer(),
                    SizedBox(
                        height: 15,
                        width: 40.w,
                        child: CustomElevatedButton(
                          title: 'Save',
                          onPressed: () {
                            widget.customerCubit.editCustomers(context,
                                id: widget.customerCubit.allCustomersModel
                                    .data[widget.index].id,
                                name: widget.editNameController.text,
                                phoneNumber:
                                widget.editPhoneNumberController.text,
                                location:
                                widget.editLocationController.text);
                            setState(() {
                              isEdit = !isEdit;
                            });
                          },
                          fill: true,
                        ))
                  ],
                ),
                Icon(
                  Icons.person,
                  size: 20.sp,
                ),
                MobileCustomUnderLineTextField(
                  hint: 'Full name',
                  controller: widget.editNameController,
                ),
                MobileCustomUnderLineTextField(
                  hint: 'Customer Num',
                  controller: widget.editPhoneNumberController,
                ),
                SizedBox(
                  height: 30,
                  width: 100.w,
                  child: DropdownButtonFormField(
                      value: widget.customerCubit.newDriver,
                      iconSize: 10.sp,
                      style: TextStyle(fontSize: 10.sp),
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
                MobileCustomUnderLineTextField(
                  controller: widget.editLocationController,
                  hint: 'Address',
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 50.w,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            backgroundColor:
                                MaterialStateProperty.all(kPrimaryColor)),
                        child: Text(
                          'Subscriber',
                          style: TextStyle(
                              fontSize: 6.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    SizedBox(
                      height: 20,
                      width: 50.w,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Text(
                                        style: TextStyle(fontSize: 15.sp),
                                        "Are you sure you want to delete ${widget.customerCubit.allCustomersModel.data[widget.index].name}?"),
                                    actions: [
                                      BlocBuilder<CustomerCubit, CustomerState>(
                                        builder: (context, state) {
                                          if(state is DeleteCustomerLoadingState){
                                            return const CircularProgressIndicator(color: kPrimaryColor,);
                                          }
                                          return TextButton(
                                              onPressed: () async {
                                                await widget.customerCubit
                                                    .deleteCustomer(
                                                        id: widget
                                                            .customerCubit
                                                            .allCustomersModel
                                                            .data[widget.index]
                                                            .id);
                                              },
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: kOnWayColor,
                                                    fontSize: 14.sp),
                                              ));
                                        },
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.black),
                                          )),
                                    ],
                                  ));
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            backgroundColor:
                                MaterialStateProperty.all(kOnWayColor)),
                        child: Text(
                          'Delete',
                          style: TextStyle(
                              fontSize: 6.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        : Container(
            width: 140.w,
            padding:
                EdgeInsets.only(right: 2.w, left: 2.w, top: 10, bottom: 10),
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(14.83)),
                border: Border.symmetric(
                    horizontal: BorderSide(width: 2, color: kPrimaryColor),
                    vertical: BorderSide(width: 5, color: kPrimaryColor)),
                color: Colors.white),
            child: Column(
              children: [
                SizedBox(
                  height: ScreenSizeUtil.screenWidth * 0.02,
                ),
                Icon(
                  Icons.person,
                  size: 20.sp,
                ),
                const SizedBox(
                  height: 12.36,
                ),
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  widget
                      .customerCubit.allCustomersModel.data[widget.index].name,
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 5.21,
                ),
                Text(
                  widget
                      .customerCubit.allCustomersModel.data[widget.index].phone,
                  style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 20.sp),
                SizedBox(
                  height: 20,
                  width: 90.w,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 2.h)),
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryColor)),
                    onPressed: null,
                    child: Text(
                      widget.customerCubit.allCustomersModel.data[widget.index]
                          .state,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Driver : ${widget.customerCubit.allCustomersModel.data[widget.index].driverName}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 8.sp,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                    widget.customerCubit.allCustomersModel.data[widget.index]
                        .address,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 8.sp,
                    )),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isEdit = !isEdit;
                        });
                      },
                      child: Center(
                          child: Container(
                        margin: const EdgeInsets.only(right: 5),
                        padding: const EdgeInsets.all(2).w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: kPrimaryColor, width: 2)),
                        child: SizedBox(
                          width: 12.w,
                          height: 14.h,
                          child: IconButton(
                            iconSize: 12.sp,
                            style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero)),
                            tooltip: "Edit information",
                            onPressed: () {
                              widget.editNameController.text = widget
                                  .customerCubit
                                  .allCustomersModel
                                  .data[widget.index]
                                  .name;
                              widget.editPhoneNumberController.text = widget
                                  .customerCubit
                                  .allCustomersModel
                                  .data[widget.index]
                                  .phone;
                              widget.editLocationController.text = widget
                                  .customerCubit
                                  .allCustomersModel
                                  .data[widget.index]
                                  .address;
                              widget.editDriverController.text = widget
                                  .customerCubit
                                  .allCustomersModel
                                  .data[widget.index]
                                  .name;
                              widget.customerCubit.newDriver = widget.customerCubit.allCustomersModel.data[widget.index].driverName;

                              setState(() {
                                isEdit = !isEdit;
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                              color: kPrimaryColor,
                              size: 10.sp,
                            ),
                          ),
                        ),
                      )),
                    ),
                  ],
                )
              ],
            ),
          );
  }
}
