import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/util/screen_util.dart';
import 'package:qrreader/feature/customers/presentation/manger/customer_cubit.dart';
import 'package:qrreader/feature/customers/presentation/view/widgets/tablet/tablet_custom_underline_field.dart';

import '../../../../../../constant.dart';
import '../../../../../home_page/presentation/view/widgets/custom_elevated_button.dart';

class TabletCustomerCard extends StatefulWidget {
  TabletCustomerCard(
      {super.key, required this.customerCubit, required this.index});

  final int index;
  final CustomerCubit customerCubit;
  final TextEditingController editNameController = TextEditingController();
  final TextEditingController editPhoneNumberController =
      TextEditingController();
  final TextEditingController editLocationController = TextEditingController();
  final TextEditingController editDriverController = TextEditingController();

  @override
  State<TabletCustomerCard> createState() => _TabletCustomerCardState();
}

class _TabletCustomerCardState extends State<TabletCustomerCard> {
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return isEdit
        ? BlocConsumer<CustomerCubit, CustomerState>(
            listener: (context, state) {
              if (state is EditCustomerSuccess) {
                setState(() {
                  isEdit = !isEdit;
                });
              }
            },
            builder: (context, state) {
              if (state is GetCustomersSuccess ) {
                widget.editNameController.text = widget
                    .customerCubit.allCustomersModel.data[widget.index].name;
                widget.editPhoneNumberController.text = widget
                    .customerCubit.allCustomersModel.data[widget.index].phone;
                widget.editLocationController.text = widget
                    .customerCubit.allCustomersModel.data[widget.index].address;
                widget.editDriverController.text =
                    widget.customerCubit.allCustomersModel.data[widget.index].name;
              }
              return Container(
                width: 390.w,
                padding: EdgeInsets.only(
                    right: 5.w, left: 5.w, top: 10.h, bottom: 10.h),
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(14.83)),
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
                          width: 30.w,
                          child: CustomElevatedButton(
                              platform: 'desktop',
                              title: 'save',
                              onPressed: () {
                                widget.customerCubit.editCustomers(context,
                                    id: widget.customerCubit.allCustomersModel
                                        .data[widget.index].id,
                                    name: widget.editNameController.text,
                                    phoneNumber:
                                        widget.editPhoneNumberController.text,
                                    location:
                                        widget.editLocationController.text);
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
                      controller: widget.editNameController,
                    ),
                    TabletCustomUnderLineTextField(
                      hint: 'Customer Num',
                      controller: widget.editPhoneNumberController,
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
                          items:  drivers.length>1?drivers.sublist(1, drivers.length)
                              .map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList():[""]
                              .map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            widget.customerCubit.newDriver= val!;
                          }),
                    ),
                    TabletCustomUnderLineTextField(
                      controller: widget.editLocationController,
                      hint: 'Address',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.customerCubit.allCustomersModel
                            .data[widget.index].bags.isNotEmpty
                            ? Text(
                          "Dis-attach: ",
                          style: TextStyle(
                              fontSize: 5.sp, color: Colors.black),
                        )
                            : const SizedBox(),
                        widget.customerCubit.allCustomersModel
                            .data[widget.index].bags.isNotEmpty
                            ? TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text(
                                      style: TextStyle(
                                          fontSize: 5.sp),
                                      "Are you sure you want to dis-attach  \nthis customer from bag which id ${widget.customerCubit.allCustomersModel.data[widget.index].bags[0]}?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop();
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                              fontSize: 5.sp,
                                              color:
                                              Colors.black),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          widget.customerCubit
                                              .disAttachCustomer(
                                              customerId: widget
                                                  .customerCubit
                                                  .allCustomersModel
                                                  .data[widget
                                                  .index]
                                                  .id,
                                              bagId: widget
                                                  .customerCubit
                                                  .allCustomersModel
                                                  .data[widget
                                                  .index]
                                                  .bags[0]);
                                        },
                                        child: Text(
                                          "Dis-attach",
                                          style: TextStyle(
                                              color: kOnWayColor,
                                              fontSize: 5.sp),
                                        )),
                                  ],
                                ));
                          },
                          child: Text(
                              '${widget.customerCubit.allCustomersModel.data[widget.index].bags[0]}',
                              style: TextStyle(
                                color: kOnWayColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 5.sp,
                              )),
                        )
                            : const SizedBox(),
                        widget.customerCubit.allCustomersModel
                            .data[widget.index].bags.length >
                            1
                            ? TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text(
                                      style: TextStyle(
                                          fontSize: 4.sp),
                                      "Are you sure you want to dis-attach  \nthis customer from bag which id ${widget.customerCubit.allCustomersModel.data[widget.index].bags[1]}?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop();
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                              fontSize: 3.5.sp,
                                              color:
                                              Colors.black),
                                        )),
                                    TextButton(
                                        onPressed: (){
                                          widget.customerCubit
                                              .disAttachCustomer(
                                              customerId: widget
                                                  .customerCubit
                                                  .allCustomersModel
                                                  .data[widget
                                                  .index]
                                                  .id,
                                              bagId: widget
                                                  .customerCubit
                                                  .allCustomersModel
                                                  .data[widget
                                                  .index]
                                                  .bags[0]);
                                        },
                                        child: Text(
                                          "Dis-attach",
                                          style: TextStyle(
                                              color: kOnWayColor,
                                              fontSize: 3.5.sp),
                                        )),
                                  ],
                                ));
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.zero)),
                          child: Text(
                              '${widget.customerCubit.allCustomersModel.data[widget.index].bags[1]}',
                              style: TextStyle(
                                color: kOnWayColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 3.sp,
                              )),
                        )
                            : const SizedBox()
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30.w,
                          height: 25.h,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          style: TextStyle(fontSize: 6.sp),
                                          widget
                                                      .customerCubit
                                                      .allCustomersModel
                                                      .data[widget.index]
                                                      .state ==
                                                  'active'
                                              ? 'Do you want to make \n ${widget.customerCubit.allCustomersModel.data[widget.index].name}\n as Inactive customer?'
                                              : 'Do you want to make \n ${widget.customerCubit.allCustomersModel.data[widget.index].name}\n as Active customer?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              widget
                                                          .customerCubit
                                                          .allCustomersModel
                                                          .data[widget.index]
                                                          .state ==
                                                      'active'
                                                  ? await widget.customerCubit
                                                      .inActiveCustomer(
                                                          id: widget
                                                              .customerCubit
                                                              .allCustomersModel
                                                              .data[
                                                                  widget.index]
                                                              .id)
                                                  : await widget.customerCubit
                                                      .activeCustomer(
                                                          id: widget
                                                              .customerCubit
                                                              .allCustomersModel
                                                              .data[
                                                                  widget.index]
                                                              .id);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Confirm",
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontSize: 4.sp),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  fontSize: 4.5.sp,
                                                  color: Colors.black),
                                            )),
                                      ],
                                    );
                                  });
                            },
                            style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                                backgroundColor: MaterialStateProperty.all(
                                    widget.customerCubit.allCustomersModel
                                                .data[widget.index].state ==
                                            'active'
                                        ? kUnsubsicriber
                                        : kPrimaryColor)),
                            child: Text(
                              widget.customerCubit.allCustomersModel
                                          .data[widget.index].state ==
                                      'active'
                                  ? 'Inactive'
                                  : 'Active',
                              style: TextStyle(
                                  fontSize: 3.5.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        SizedBox(
                          width: 30.w,
                          height: 25,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text(
                                            style: TextStyle(fontSize: 5.sp),
                                            "Are you sure you want to delete \n${widget.customerCubit.allCustomersModel.data[widget.index].name}?"),
                                        actions: [
                                          TextButton(
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
                                                    fontSize: 4.5.sp),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    fontSize: 4.5.sp,
                                                    color: Colors.black),
                                              )),
                                        ],
                                      ));
                            },
                            style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                                backgroundColor:
                                    MaterialStateProperty.all(kOnWayColor)),
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                  fontSize: 3.5.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          )
        : BlocBuilder<CustomerCubit, CustomerState>(
            builder: (context, state) {
              if (state is GetCustomersSuccess) {
                widget.editNameController.text = widget
                    .customerCubit.allCustomersModel.data[widget.index].name;
                widget.editPhoneNumberController.text = widget
                    .customerCubit.allCustomersModel.data[widget.index].phone;
                widget.editLocationController.text = widget
                    .customerCubit.allCustomersModel.data[widget.index].address;
                widget.editDriverController.text = widget
                    .customerCubit.allCustomersModel.data[widget.index].driverName;
                 widget.customerCubit.newDriver = widget
                    .customerCubit.allCustomersModel.data[widget.index].driverName;

              }
              return Container(
                width: 390.w,
                padding: EdgeInsets.only(
                    right: 5.w, left: 5.w, top: 10.h, bottom: 10.h),
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(14.83)),
                    border: Border.symmetric(
                        horizontal: BorderSide(
                            width: 2.5,
                            color: widget.customerCubit.allCustomersModel
                                        .data[widget.index].state ==
                                    'active'
                                ? kPrimaryColor
                                : kUnsubsicriber),
                        vertical: BorderSide(
                            width: 20,
                            color: widget.customerCubit.allCustomersModel
                                        .data[widget.index].state ==
                                    'active'
                                ? kPrimaryColor
                                : kUnsubsicriber)),
                    color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('ID: ${widget.customerCubit.allCustomersModel.data[widget.index].id}'),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Icon(
                      Icons.person,
                      size: 16.sp,
                    ),
                    const SizedBox(
                      height: 12.36,
                    ),
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      widget.customerCubit.allCustomersModel.data[widget.index]
                          .name,
                      style: TextStyle(
                          fontSize: 6.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 5.21.h,
                    ),
                    Text(
                      'Number: ${widget.customerCubit.allCustomersModel.data[widget.index].phone}',
                      style: TextStyle(
                          fontSize: 4.5.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),


                    SizedBox(
                      height: 25.h,
                      width: 35.w,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10)),
                            backgroundColor: MaterialStateProperty.all(widget
                                        .customerCubit
                                        .allCustomersModel
                                        .data[widget.index]
                                        .state ==
                                    'active'
                                ? kPrimaryColor
                                : kUnsubsicriber)),
                        child: Text(
                          widget.customerCubit.allCustomersModel
                              .data[widget.index].state,
                          style: TextStyle(
                              fontSize: ScreenSizeUtil.screenWidth * 0.01,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Driver : ${widget.customerCubit.allCustomersModel.data[widget.index].driverName}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 5.sp,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                        'Address : ${widget.customerCubit.allCustomersModel.data[widget.index].address}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 5.sp,
                        )),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                        'Reserved Bags : ${widget.customerCubit.allCustomersModel.data[widget.index].reservedBags}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 5.sp,
                        )),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            widget.editNameController.text = widget
                                .customerCubit.allCustomersModel.data[widget.index].name;
                            widget.editPhoneNumberController.text = widget
                                .customerCubit.allCustomersModel.data[widget.index].phone;
                            widget.editLocationController.text = widget
                                .customerCubit.allCustomersModel.data[widget.index].address;
                            widget.editDriverController.text =
                                widget.customerCubit.allCustomersModel.data[widget.index].name;
                            widget.customerCubit.newDriver = widget.customerCubit.allCustomersModel.data[widget.index].driverName;
                            setState(() {
                              isEdit = !isEdit;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                                border: Border.all(color: Colors.black)),
                            child: Center(
                                child: Icon(
                              Icons.edit,
                              color: kPrimaryColor,
                              size: 5.sp,
                            )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
  }
}
