import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/feature/users/presentation/manger/user_cubit.dart';

import '../../../../../constant.dart';
import '../../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../../../home_page/presentation/view/widgets/custom_elevated_button.dart';
import '../desktop_user_page.dart';
import 'desktop_add_user_page.dart';

class TabletAddUserPage extends StatelessWidget {
  const TabletAddUserPage({super.key, required this.isEdit});
  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if(state is AddUserSuccessState){
          customSnackBar(context, state.message);
          Navigator.of(context).pop();
        }
        if (state is AddUserFailureState) {
          customSnackBar(context, state.error,color: kOnWayColor);
        }
        if (state is AddUserLoadingState){
          customSnackBar(context, 'Loading...',duration: 20,color: kUnsubsicriber);
        }
        if (state is GetUsersSuccessState || state is AddUserSuccessState || state is DeleteUsersSuccessState) {
          context.read<UserCubit>().rows.clear();
          for (int i = 0;
          i < context.read<UserCubit>().allUsersModel.data.length;
          i++) {
            if(context.read<UserCubit>().allUsersModel.data[i].id==1)continue;
            context.read<UserCubit>().rows.add(DataRow(cells: [
              DataCell(Text(
                  context.read<UserCubit>().allUsersModel.data[i].name)),
              DataCell(Text(
                  context.read<UserCubit>().allUsersModel.data[i].phone)),
              DataCell(Text(
                  context.read<UserCubit>().allUsersModel.data[i].role)),
              DataCell(Row(
                children: [
                  CustomEditTextButton(
                    userCubit: context.read<UserCubit>(),
                    i: i,
                    isTablet: false,
                  ),
                  CustomDeleteTextButton(
                    userCubit: context.read<UserCubit>(),
                    i: i,
                    isTablet: false,
                  ),
                ],
              )),
            ]));
          }
        }
      },
      builder: (context, state) {
        UserCubit userCubit = context.read();
        return Scaffold(
          appBar: AppBar(
            title: Text(isEdit ?'Edit user information': "Add new user"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                userCubit.fullNameController.clear();
                userCubit.phoneNumberController.clear();
                userCubit.selectedJob='';
                Navigator.of(context).pop();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 50.w,
                    height: 40,
                    child: CustomElevatedButton(
                      title: 'Add User',
                      onPressed: () {},
                      fill: true,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [ isEdit && userCubit.imageController.text!=''?
                        ClipOval(child: Image.network(userCubit.imageController.text)):
                          userCubit.bytesData != null
                              ? Image.memory(
                            userCubit.bytesData!,
                            width: 160.w,
                            height: 180,
                            fit: BoxFit.contain,
                          )
                              : Icon(
                            Icons.person,
                            size: 50.sp,
                          ),
                          userCubit.bytesData == null ? IconButton(
                              tooltip: 'Upload image',
                              icon: Icon(Icons.camera_alt,
                                  size: 10.sp, color: kUnsubsicriber),
                              onPressed: () async {
                                userCubit.startWebFilePicker();
                              }) : IconButton(
                            icon: const Icon(Icons.cancel_outlined), onPressed: () {
                            userCubit.cancelPhoto();
                          },),
                        ],
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Full Name',
                            style: TextStyle(
                                color: Colors.black, fontSize: 6.sp),
                          ),
                          SizedBox(
                            width: 80.w,
                            height: 30,
                            child: DesktopCustomAddUserField(controller: userCubit.fullNameController, isSecure: false,suffixIcon: const SizedBox(),),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Phone Number',
                            style: TextStyle(
                                color: Colors.black, fontSize: 6.sp),
                          ),
                          SizedBox(
                            width: 80.w,
                            height: 30,
                            child: DesktopCustomAddUserField(controller: userCubit.phoneNumberController, isSecure: false,suffixIcon: const SizedBox(),),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Job Position', style: TextStyle(
                              color: Colors.black, fontSize: 6.sp),),
                          SizedBox(
                            width: 80.w,
                            height: 40,
                            child: DropdownButtonFormField<String>(
                              style: TextStyle(fontSize: 5.sp),
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: kPrimaryColor), // Custom underline color
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: kPrimaryColor,
                                      width: 2), // Focused underline
                                ),
                              ),
                              hint: const Text('Select Job Position'),
                              items: <String>[
                                'Driver',
                                'worker',
                                'Admin'
                              ].map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              onChanged: (String? newValue) {},
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Password',
                            style: TextStyle(
                                color: Colors.black, fontSize: 6.sp),
                          ),
                          SizedBox(
                            width: 80.w,
                            height: 30,
                            child: DesktopCustomAddUserField(controller: userCubit.passwordController, isSecure: userCubit.isSecure,
                              suffixIcon:  IconButton(
                                onPressed: () {
                                  userCubit.changePasswordSecure();
                                },
                                icon: Icon(size: 6.sp,userCubit.passwordIcon),
                              ),),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Confirm Password',
                            style: TextStyle(
                                color: Colors.black, fontSize: 6.sp),
                          ),
                          SizedBox(
                            width: 80.w,
                            height: 30,
                            child: DesktopCustomAddUserField(controller: userCubit.confirmPasswordController, isSecure: userCubit.confirmIsSecure,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  userCubit.changeConfirmPasswordSecure();
                                },
                                icon: Icon(size: 6.sp,userCubit.confirmPasswordIcon),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 40.w,
                              ),
                              SizedBox(
                                  width: 40.w,
                                  child: CustomElevatedButton(
                                    title: 'Save',
                                    onPressed: () {
                                      userCubit.addUser();
                                    },
                                    fill: false,
                                  )),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TabletCustomAddUserField extends StatelessWidget {
  const TabletCustomAddUserField({
    super.key, required this.controller,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
          hintText: '',
          hintStyle: TextStyle(fontSize: 5.sp),
          border: const UnderlineInputBorder()),
    );
  }
}
