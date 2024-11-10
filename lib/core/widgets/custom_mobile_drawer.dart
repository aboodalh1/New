import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant.dart';
import '../../feature/home_page/presentation/manger/home_cubit.dart';
import '../../feature/home_page/presentation/view/desktop_home_page.dart';

class CustomMobileDrawer extends StatelessWidget {
  const CustomMobileDrawer({
    super.key,
    required this.homeCubit,
  });

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 220.w,
      backgroundColor: kPrimaryColor,
      child: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0.sp),
              child: Text('Be Healthy',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w300)),
            ),
            SizedBox(
              height: 40.sp,
            ),
            CustomTextButton(
              isSelected: homeCubit.currentIndex==0?true:false,
              function: () {
                homeCubit.changePage(index: 0);
                homeCubit.storeLastRoute('home');
              },
              icon: Icons.home_filled,
              title: 'Home',
            ),
            CustomTextButton(
                isSelected: homeCubit.currentIndex==1?true:false,
              function: () {
                homeCubit.changePage(index: 1);
                homeCubit.storeLastRoute('customers');
              },
              icon: CupertinoIcons.person,
              title: 'Customers',
            ),
            CustomTextButton(
              isSelected: homeCubit.currentIndex==2?true:false,
              function: () {
                homeCubit.changePage(index: 2);
                homeCubit.storeLastRoute('users');
              },
              icon: CupertinoIcons.person_3,
              title: 'Users',
            ),
            CustomTextButton(
              isSelected: homeCubit.currentIndex==3?true:false,
              function: () {
                homeCubit.changePage(index: 3);
                homeCubit.storeLastRoute('reports');
              },
              icon: CupertinoIcons.doc,
              title: 'Reports',
            ),
            CustomTextButton(
              isSelected: homeCubit.currentIndex==4?true:false,
              function: () {
                homeCubit.changePage(index: 4);
                homeCubit.storeLastRoute('bags');
              },
              icon: Icons.shopping_bag_rounded,
              title: 'Bags',
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0.w),
              child: const Divider(
                height: 0.2,
              ),
            ),
            CustomTextButton(
              isSelected: false,
              function: () {
                homeCubit.signOut();

              },
              title: "Sign out",
              icon: Icons.login,
            )
          ],
        ),
      ),
    );
  }
}
