import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/feature/home_page/presentation/view/widgets/custom_elevated_button.dart';
import 'package:qrreader/feature/users/presentation/manger/user_cubit.dart';
import '../../../../../constant.dart';
import '../../../../../core/util/screen_util.dart';
import '../../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';

class DesktopAddUserPage extends StatelessWidget {
  const DesktopAddUserPage({super.key, required this.isEdit});
  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if(state is AddUserSuccessState){
          customSnackBar(context, state.message);
          Navigator.of(context).pop();
        }if(state is EditUsersSuccessState){
          customSnackBar(context, state.message);
          Navigator.of(context).pop();
        }
        if (state is AddUserFailureState) {
          customSnackBar(context, state.error,color: kOnWayColor,duration: 500);
        }if (state is EditUsersFailureState) {
          customSnackBar(context, state.error,color: kOnWayColor,duration: 500);
        }
        if (state is AddUserLoadingState){
          customSnackBar(context, 'Loading...',duration: 500,color: kUnsubsicriber);
        }
      },
      builder: (context, state) {
        if(state is EditUsersLoadingState){
          return Scaffold(
            body: Center(child: Container(
              decoration: BoxDecoration(color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10.r)
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              width: 80.w,height: 200.h,child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Loading...",style: TextStyle(fontSize: 8.sp,color: const Color(0xffFFFFFF)),),
                SizedBox(height: 20.h,),
                const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),),),
          );}
        UserCubit userCubit = context.read<UserCubit>();
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
                  CustomElevatedButton(
                    title: 'Add User',
                    onPressed: () {},
                    fill: true,
                    platform: 'desktop',
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          isEdit && userCubit.imageController.text!=''?
                              ClipOval(child: Image.network(
                                  width: 55.w,
                                  height: 200.h,
                                  userCubit.imageController.text)):
                          userCubit.bytesData != null
                              ? ClipOval(
                                child: Image.memory(
                                  width: 55.w,
                                  height: 200.h,
                                    userCubit.bytesData!,
                                    fit: BoxFit.cover,
                                  ),
                              )
                              : Icon(
                                  Icons.person,
                                  size: 40.sp,
                                ),
                          userCubit.bytesData == null
                              ? IconButton(
                                  tooltip: 'Upload image',
                                  icon: Icon(Icons.camera_alt,
                                      size: 10.sp, color: kUnsubsicriber),
                                  onPressed: () async {
                                    userCubit.startWebFilePicker();
                                  })
                              : IconButton(
                                  icon: const Icon(Icons.cancel_outlined),
                                  onPressed: () {
                                    userCubit.cancelPhoto();
                                  },
                                ),
                        ],
                      ),
                      SizedBox(
                        width: 30.sp,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Full Name',
                            style: TextStyle(
                                color: Colors.black, fontSize: 5.sp),
                          ),
                          SizedBox(
                            width: 80.w,
                            height: 40,
                            child: DesktopCustomAddUserField(
                              suffixIcon: const SizedBox(),isSecure: false,
                                controller: userCubit.fullNameController),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Phone Number',
                            style: TextStyle(
                                color: Colors.black, fontSize: 5.sp),
                          ),
                          SizedBox(
                            width: 80.w,
                            height: 40,
                            child: DesktopCustomAddUserField(
                              isSecure: false,suffixIcon: const SizedBox(),
                                controller: userCubit.phoneNumberController),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Job Position',
                            style: TextStyle(
                                color: Colors.black, fontSize: 5.sp),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 80.w,
                            height: 40,
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          kPrimaryColor), // Custom underline color
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: kPrimaryColor,
                                      width: 2), // Focused underline
                                ),
                              ),
                              hint: const Text('Select Job Position'),
                              items: <String>[
                                'driver',
                                'worker',
                                'admin'
                              ].map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              onChanged: (String? newValue) {
                                userCubit.changeDropDownValue(
                                    value: newValue!);
                              },
                            ),
                          ),
                         if(!isEdit) const SizedBox(
                            height: 10,
                          ),
                          if(!isEdit)Text(
                            'Password',
                            style: TextStyle(
                                color: Colors.black, fontSize: 5.sp),
                          ),
                          if(!isEdit)  SizedBox(
                            width: 80.w,
                            height: 40,
                            child: DesktopCustomAddUserField(
                                isSecure: userCubit.isSecure,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    userCubit.changePasswordSecure();
                                  },
                                  icon: Icon(size: 6.sp,userCubit.passwordIcon),
                                ),
                                controller: userCubit.passwordController),
                          ),
                          if(!isEdit)  const SizedBox(
                            height: 10,
                          ),
                          if(!isEdit)   Text(
                            'Confirm Password',
                            style: TextStyle(
                                color: Colors.black, fontSize: 5.sp),
                          ),
                          if(!isEdit)    SizedBox(
                            width: 80.w,
                            height: 40,
                            child: DesktopCustomAddUserField(
                              controller: userCubit.confirmPasswordController,
                              isSecure: userCubit.confirmIsSecure,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    userCubit.changeConfirmPasswordSecure();
                                  },
                                  icon: Icon(
                                    size: 6.sp,
                                    userCubit.confirmPasswordIcon,
                                  )),
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
                                     title: isEdit? 'Save':'Add',
                                    onPressed: () {
                                  isEdit? userCubit.editUser():  userCubit.addUser();
                                    },
                                    fill: false,
                                    platform: 'desktop',
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

class DesktopCustomAddUserField extends StatelessWidget {
  const DesktopCustomAddUserField({
    super.key,
    required this.controller,
    required this.isSecure,
    required this.suffixIcon,
  });

  final TextEditingController controller;
  final bool isSecure;
  final Widget suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isSecure,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: '',
          hintStyle: TextStyle(fontSize: 6.5.sp),
          border: const UnderlineInputBorder()),
    );
  }
}
