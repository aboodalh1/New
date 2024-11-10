import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../manger/auth_cubit.dart';
import '../custom_text_field.dart';

class TabletLoginCard extends StatelessWidget {
  const TabletLoginCard({super.key, required this.authCubit, context});

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380.h,
      width: 160.w,
      padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 8.h),
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
              "Sign In",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomTextField(
              isCenter: false,
              isTablet: true,
              controller: authCubit.phoneNumberController,
              label: 'Enter phone number',
              isSecure: false,
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomTextField(
              isCenter: false,
              isTablet: true,
              controller: authCubit.passwordController,
              label: 'Enter password',
              suffixIcon: GestureDetector(
                onTap: (){
                  authCubit.changeSecure();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.h),
                  child: Icon(
                    authCubit.passwordIcon,
                    size: 8.sp,
                  ),
                ),
              ),
              isSecure: authCubit.isSecure,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Spacer(),
                Text(
                  'Forget password?',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 6.sp,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(Size(150.w, 60.h)),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  backgroundColor:
                      const MaterialStatePropertyAll(Color(0xff0F663C)),
                ),
                onPressed: () {
                  authCubit.login(context);
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 7.sp,
                      fontWeight: FontWeight.w400),
                ))
          ],
        ),
      ),
    );
  }
}
