import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant.dart';
import '../../feature/home_page/presentation/manger/home_cubit.dart';

class DesktopDrawer extends StatelessWidget {
  const DesktopDrawer({
    super.key, required this.homeCubit,
  });
  final HomeCubit homeCubit;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: kPrimaryColor,
          height: double.infinity,
          width: 75.w,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w,vertical: 5.h),
                child: Text("Be Healthy",style: TextStyle(
                    fontSize: 9.sp,color: Colors.white
                ),),
              ),
              Icon(CupertinoIcons.person_solid,size: 23.sp,color: Colors.white,),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0.h),
                child: Text('Hello, ${homeCubit.currentName}',style: const TextStyle(
                  color: Colors.white
                )),
              ),
              CustomTextButton(
                isSelected: homeCubit.currentIndex == 0? true:false,
                onPressed: (){
                  homeCubit.getAllReads();
                  homeCubit.storeLastRoute('home');
                  homeCubit.changePage( index: 0);
                },
                icon: Icons.home_filled,
                title: 'Home',
              ),
              CustomTextButton(
                isSelected: homeCubit.currentIndex == 1? true:false,
                onPressed: (){
                  homeCubit.storeLastRoute('customers');
                  homeCubit.changePage( index: 1);
                },
                icon: CupertinoIcons.person,
                title: 'Customers',
              ),
              CustomTextButton(
                isSelected: homeCubit.currentIndex == 2? true:false,
                onPressed: (){
                  homeCubit.changePage( index: 2);
                   homeCubit.storeLastRoute('users');
                },
                icon: CupertinoIcons.person_3,
                title: 'Users',
              ),
              CustomTextButton(
                isSelected: homeCubit.currentIndex == 3? true:false,
                icon: CupertinoIcons.doc,
                title: 'Reports',
                onPressed: () {
                  homeCubit.storeLastRoute('reports');
                  homeCubit.changePage( index: 3);
                },
              ),
              CustomTextButton(
                isSelected: homeCubit.currentIndex == 4? true:false,
                onPressed: () {
                  homeCubit.changePage( index: 4);
                  homeCubit.storeLastRoute('bags');
                },
                icon: Icons.shopping_bag_rounded,
                title: 'Bags',
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Divider(
                  height: 0.2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomTextButton(
                  isSelected: false,
                  onPressed: () {
                    showDialog(context: context, builder: (context) => AlertDialog(
                      content: Text('Do you want to sign out?',style: TextStyle(fontSize: 6.sp),),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text('No',style: TextStyle(fontSize: 5.sp,color: Colors.black),)),
                        TextButton(onPressed: (){
                            homeCubit.signOut();

                          }, child: Text('Yes',style: TextStyle(fontSize: 5.sp,color: kPrimaryColor),)),
                      ],
                    ));
                   },
                  title: "Sign out",
                  icon: Icons.login,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isSelected;
  const CustomTextButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? kSecondaryColor : Colors.transparent,
      ),
        height: 60.h,
      child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
          onPressed: onPressed ,
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 7.sp,
              ),
               SizedBox(
                width: 5.w,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 5.sp,
                    fontWeight: FontWeight.w200,
                    color: Colors.white),
              )
            ],
          )),
    );
  }
}
