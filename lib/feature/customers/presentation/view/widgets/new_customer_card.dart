import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/feature/customers/presentation/manger/customer_cubit.dart';

import '../../../../../constant.dart';
import '../../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../../../../core/widgets/custom_under_line_field.dart';
import '../../../../home_page/presentation/view/widgets/custom_elevated_button.dart';

class NewCustomerCard extends StatefulWidget {
   NewCustomerCard({
    super.key, required this.customerCubit,required this.isEdit
  });
  final CustomerCubit customerCubit;
  bool isEdit = false;
  @override
  State<NewCustomerCard> createState() => _NewCustomerCardState();
}

class _NewCustomerCardState extends State<NewCustomerCard> {

  @override
  Widget build(BuildContext context) {
    return widget.isEdit? Container(
        height: 440.h,
        width: 390.w,
        padding:
        EdgeInsets.only(right: 5.w, left: 5.w, top: 20.h, bottom: 10.h),
        margin:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            border: Border.all(width: 2, color: kPrimaryColor),
            color: Colors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
                IconButton(onPressed: (){setState(() {
                  widget.isEdit=!widget.isEdit;
                });}, icon: const Icon(Icons.cancel)),
                const Spacer(),
                SizedBox(
                    height: 20,
                    width: 20.w,
                    child: CustomElevatedButton(platform: 'desktop',title: 'Add', onPressed: ()async{ try {
                      await widget.customerCubit.addCustomers(context,
                          name: widget.customerCubit.newNameController.text,
                          phoneNumber: widget.customerCubit.newPhoneNumberController.text,
                          location: widget
                              .customerCubit.newLocationController.text);
                    } catch (e) {
                      customSnackBar(context, e.toString());
                    }}, fill: true,))
              ] ,
            ),
            Icon(
              Icons.person,
              size: 16.sp,
            ),
             CustomUnderLineTextField(hint: 'Full name', controller: widget.customerCubit.newNameController,),
             CustomUnderLineTextField(hint: 'Customer Num',controller: widget.customerCubit.newPhoneNumberController),
             SizedBox(
               height: 40,
               width: 40.w,
               child: DropdownButtonFormField(
                    isExpanded: true,
                   value: null,
                   iconSize: 5.sp,
                   isDense: true,
                   hint: Text('Select Driver',style: TextStyle(fontSize: 3.sp),),
                   items:  drivers.sublist(1, drivers.length).map<DropdownMenuItem<String>>(
                     (String value) {
                   return DropdownMenuItem<String>(
                     value: value,
                     child: Text(value),
                   );
                 },
               ).toList(), onChanged: (val){
                     widget.customerCubit.newDriver= val!;
               }),
             ),
             CustomUnderLineTextField(controller: widget.customerCubit.newLocationController,
              hint: 'Address',
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 20.w,
              height: 25,child: ElevatedButton(
              onPressed: ()async{ try {
      await widget.customerCubit.addCustomers(context,
      name: widget.customerCubit.newNameController.text,
      phoneNumber: widget.customerCubit.newPhoneNumberController.text,
      location: widget
          .customerCubit.newLocationController.text);
      } catch (e) {
      customSnackBar(context, e.toString());
      }},
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  backgroundColor:
                  MaterialStateProperty.all(kSecondaryColor)),
              child: Text(
                'Add',
                style: TextStyle(
                    fontSize: 2.5.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ),
            )
          ],
        ),
      ):
    Container(
        height: 440,
        width: 390.w,
        padding:
        EdgeInsets.only(right: 5.w, left: 5.w, top: 20.h, bottom: 10.h),
        margin:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
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
                child:  IconButton(
                  onPressed: (){
                    setState(() {
                      widget.isEdit=!widget.isEdit;
                    });
                  },
                  icon:Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 15.sp
                  )
                  )
              ),
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
