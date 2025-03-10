import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../constant.dart';
import '../../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../../../../core/widgets/mobile/custom_mobile_elevated_button.dart';
import '../../manger/user_cubit.dart';
import 'desktop_add_user_page.dart';

class MobileAddUserPage extends StatelessWidget {
  const MobileAddUserPage({super.key, required this.isEdit});
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if(state is UploadErrorState){
          customSnackBar(context, state.error,color: kOnWayColor,duration: 15);
        }
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
        UserCubit userCubit = context.read<UserCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Add New User",
              style: TextStyle(fontSize: 15.sp),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 55.0.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      userCubit.bytesData != null
                          ? Image.memory(
                              userCubit.bytesData!,
                              width: 60.w,
                              height: 80,
                              fit: BoxFit.contain,
                            )
                          : Icon(
                              Icons.person,
                              size: 60.sp,
                            ),
                      userCubit.bytesData == null
                          ? Positioned(
                              top: 35,
                              left: 30.w,
                              child: IconButton(
                                  tooltip: 'Upload image',
                                  icon: Icon(Icons.camera_alt,
                                      size: 20.sp, color: kUnsubsicriber),
                                  onPressed: () async {
                                    userCubit.startWebFilePicker();
                                  }),
                            )
                          : IconButton(
                              icon: const Icon(Icons.cancel_outlined),
                              onPressed: () {
                                userCubit.cancelPhoto();
                              },
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 50.w,
                  ),
                  const PaddingText(
                    title: 'Full Name',
                  ),
                  SizedBox(
                    width: 160.w,
                    height: 40,
                    child:  DesktopCustomAddUserField(controller: userCubit.fullNameController, suffixIcon: const SizedBox(), isSecure: false,),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const PaddingText(
                    title: 'Phone number',
                  ),
                  SizedBox(
                    width: 160.w,
                    height: 40,
                    child:  DesktopCustomAddUserField(controller: userCubit.phoneNumberController, isSecure: false,suffixIcon: const SizedBox(),),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const PaddingText(
                    title: 'Job Postition',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 160.w,
                    height: 40,
                    child: DropdownButtonFormField<String>(
                      iconSize: 18.sp,
                      style: TextStyle(fontSize: 12.sp, fontFamily: 'Mono'),
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
                      items: <String>['Driver', 'worker', 'Admin']
                          .map<DropdownMenuItem<String>>(
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
                  if(!isEdit)   const PaddingText(
                    title: 'Password',
                  ),
                  if(!isEdit)    SizedBox(
                    width: 160.w,
                    height: 40,
                    child:  DesktopCustomAddUserField(controller: userCubit.passwordController, isSecure: userCubit.isSecure,
                    suffixIcon:  IconButton(
                          onPressed: () {
                            userCubit.changePasswordSecure();
                          },
                          icon: Icon(size: 15.sp,userCubit.passwordIcon),
                        ),),
                  ),
                  if(!isEdit)   const SizedBox(
                    height: 10,
                  ),
                  if(!isEdit)    const PaddingText(
                    title: 'Confirm Password',
                  ),
                  if(!isEdit) SizedBox(
                    width: 160.w,
                    height: 40,
                    child:  DesktopCustomAddUserField(controller: userCubit.confirmPasswordController, isSecure: userCubit.confirmIsSecure,
                    suffixIcon: IconButton(
                          onPressed: () {
                            userCubit.changeConfirmPasswordSecure();
                          },
                          icon: Icon(size: 15.sp,userCubit.confirmPasswordIcon),
                        ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 240.w,
                  ),
                  SizedBox(
                      width: 140.w,
                      child: CustomMobileElevatedButton(
                        title: isEdit? 'Save':'Add',
                        onPressed: () {
                          isEdit? userCubit.editUser():  userCubit.addUser();
                        },
                        fill: false,
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PaddingText extends StatelessWidget {
  const PaddingText({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 50.0.w),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
