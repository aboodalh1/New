import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../constant.dart';
import '../../../manger/auth_cubit.dart';
import 'mobile_custom_text_field.dart';

class MobileLoginCard extends StatelessWidget {
  const MobileLoginCard({
    super.key,
    required this.authCubit,
  });

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320.h,
      width: 250.w,
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0.r),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Sign In to your account",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 15.h,
            ),
            MobileCustomTextField(
              isCenter:false,
              isSecure: false,
              controller: authCubit.phoneNumberController,
              label: 'Enter phone number',
            ),
            SizedBox(
              height: 20.h,
            ),
            MobileCustomTextField
              (isCenter:false,
              isSecure: authCubit.isSecure,
              controller: authCubit.passwordController,
              label: 'Enter password',
              suffixIcon: GestureDetector(
                onTap: (){
                  authCubit.changeSecure();
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Icon(authCubit.passwordIcon,size: 18.sp,)
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: (){},
                  child: Text(
                    'Forget password?',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  minimumSize:
                  MaterialStatePropertyAll(Size(100.w, 40.h)),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  backgroundColor:
                  const MaterialStatePropertyAll(kPrimaryColor),
                ),
                onPressed: () {authCubit.login(context);},
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ))
          ],
        ),
      ),
    );
  }
}