import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/feature/customers/presentation/manger/customer_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../constant.dart';
import '../../../../../core/widgets/custom_under_line_field.dart';
import '../../../../home_page/presentation/view/widgets/custom_elevated_button.dart';

class CustomerCard extends StatefulWidget {
  CustomerCard({super.key, required this.customerCubit, required this.index});

  final CustomerCubit customerCubit;
  final int index;
  final TextEditingController editNameController = TextEditingController();
  final TextEditingController editPhoneNumberController =
      TextEditingController();
  final TextEditingController editLocationController = TextEditingController();
  final TextEditingController editDriverController = TextEditingController();

  @override
  State<CustomerCard> createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {
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
              if (state is GetCustomersSuccess) {}
              return Container(
                width: 390.w,
                padding: EdgeInsets.only(
                    right: 5.w, left: 5.w, top: 20.h, bottom: 10.h),
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
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
                            height: 20,
                            width: 20.w,
                            child: CustomElevatedButton(
                              platform: 'desktop',
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
                              },
                              fill: true,
                            )),
                      ],
                    ),
                    Icon(
                      Icons.person,
                      size: 16.sp,
                    ),
                    CustomUnderLineTextField(
                      hint: 'Full name',
                      controller: widget.editNameController,
                    ),
                    CustomUnderLineTextField(
                        hint: 'Customer Num',
                        controller: widget.editPhoneNumberController),
                    SizedBox(
                      height: 40,
                      width: 40.w,
                      child: DropdownButtonFormField(
                        value: widget.customerCubit.newDriver,
                          isExpanded: true,
                          iconSize: 5.sp,
                          isDense: true,
                          hint: Text(
                            'Select Driver',
                            style: TextStyle(fontSize: 3.sp),
                          ),
                          items: drivers.sublist(1, drivers.length)
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
                    CustomUnderLineTextField(
                      controller: widget.editLocationController,
                      hint: 'Address',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20.w,
                          height: 25,
                          child: ElevatedButton(
                            onPressed: () {
                              widget.customerCubit.allCustomersModel
                                          .data[widget.index].state ==
                                      'active'
                                  ? widget.customerCubit.inActiveCustomer(
                                      id: widget.customerCubit.allCustomersModel
                                          .data[widget.index].id)
                                  : widget.customerCubit.activeCustomer(
                                      id: widget.customerCubit.allCustomersModel
                                          .data[widget.index].id);
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
                                  fontSize: 2.5.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        SizedBox(
                          width: 20.w,
                          height: 25,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text(
                                            style: TextStyle(fontSize: 4.sp),
                                            "Are you sure you want to delete \n${widget.customerCubit.allCustomersModel.data[widget.index].name}?"),
                                        actions: [

                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "Cancel",
                                                style:
                                                    TextStyle(fontSize: 3.5.sp,color: Colors.black),
                                              )),
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
                                                    fontSize: 3.5.sp),
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
                                  fontSize: 2.5.sp,
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
        : Container(
            width: 390.w,
            padding:
                EdgeInsets.only(right: 5.w, left: 5.w, top: 10.h, bottom: 10.h),
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(14.83.r)),
                border: Border.symmetric(
                    horizontal: BorderSide(
                        width: 2.5,
                        color: widget.customerCubit.allCustomersModel
                                    .data[widget.index].state ==
                                'inactive'
                            ? kUnsubsicriber
                            : kPrimaryColor),
                    vertical: BorderSide(
                        width: 20,
                        color: widget.customerCubit.allCustomersModel
                                    .data[widget.index].state ==
                                'inactive'
                            ? kUnsubsicriber
                            : kPrimaryColor)),
                color: Colors.white),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'ID: ${widget.customerCubit.allCustomersModel.data[widget.index].id}',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Icon(
                  Icons.person,
                  size: 16.sp,
                ),
                const SizedBox(
                  height: 12.36,
                ),
                Text(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  widget
                      .customerCubit.allCustomersModel.data[widget.index].name,
                  style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 5.21,
                ),
                Text(
                  'Number: ${widget.customerCubit.allCustomersModel.data[widget.index].phone}',
                  style:
                      TextStyle(fontSize: 3.4.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 18.27.h,
                ),
                SizedBox(
                  height: 25,
                  width: 26.w,
                  child: ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(10)),
                        backgroundColor: MaterialStateProperty.all(widget
                                    .customerCubit
                                    .allCustomersModel
                                    .data[widget.index]
                                    .state ==
                                'inactive'
                            ? kUnsubsicriber
                            : kPrimaryColor)),
                    child: Text(
                      widget.customerCubit.allCustomersModel.data[widget.index]
                          .state,
                      style: TextStyle(
                          fontSize: 3.sp,
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
                    fontSize: 3.sp,
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                !widget.customerCubit.allCustomersModel.data[widget.index]
                        .address
                        .startsWith('http')
                    ? Text(
                        'Address : ${widget.customerCubit.allCustomersModel.data[widget.index].address}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 3.sp,
                        ))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Address: ', style: TextStyle()),
                          GestureDetector(
                            onTap: () async {
                              if (await canLaunchUrl(Uri.parse(widget
                                  .customerCubit
                                  .allCustomersModel
                                  .data[widget.index]
                                  .address))) {
                                await launchUrl(Uri.parse(widget
                                    .customerCubit
                                    .allCustomersModel
                                    .data[widget.index]
                                    .address));
                              } else {
                                throw 'Could not launch $widget.customerCubit.allCustomersModel.data[widget.index].address';
                              }
                            },
                            child: const Text(
                              'See on Map',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                    'Reserved Bags: ${widget.customerCubit.allCustomersModel.data[widget.index].reservedBags}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 3.sp,
                    )),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.customerCubit.allCustomersModel.data[widget.index]
                        .bags.isNotEmpty?  Text(
                        'Bags ID: ${widget.customerCubit.allCustomersModel.data[widget.index].bags[0]}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 3.sp,
                        )):const SizedBox(),
                    widget.customerCubit.allCustomersModel.data[widget.index]
                                .bags.length >
                            1
                        ? Text(
                            ' , ${widget.customerCubit.allCustomersModel.data[widget.index].bags[1]}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 3.sp,
                            ))
                        : const SizedBox()
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        widget.editNameController.text = widget.customerCubit
                            .allCustomersModel.data[widget.index].name;
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
                        widget.editDriverController.text = widget.customerCubit
                            .allCustomersModel.data[widget.index].name;
                        widget.customerCubit.newDriver = widget.customerCubit.allCustomersModel.data[widget.index].driverName;
                        setState(() {
                          isEdit = !isEdit;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Icon(
                          Icons.edit,
                          color: kPrimaryColor,
                          size: 4.sp,
                        )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
  }
}
