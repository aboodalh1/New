import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/feature/home_page/presentation/manger/home_cubit.dart';

import '../../../../../../constant.dart';


class TabletDrawer extends StatelessWidget {
  const TabletDrawer({
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
          width: 120.w,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w,vertical: 10.h),
                child: Text("Be Healthy",style: TextStyle(
                  fontSize: 14.sp,color: Colors.white
                ),),
              ),
              Icon(Icons.person,size: 25.sp,color: Colors.white,),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0.h),
                child: Text('Hello, ${homeCubit.currentName}',style: TextStyle(
                  color: Colors.white,
                  fontSize: 8.sp,
                )),
              ),
              const Spacer(flex: 1,),
              TabletCustomTextButton(
                isSelected: homeCubit.currentIndex==0? true:false,
                onPressed: (){
                  homeCubit.changePage(index: 0);
                  homeCubit.storeLastRoute('home');
                },
                icon: Icons.home_filled,
                title: 'Home',
              ),
              TabletCustomTextButton(
                isSelected: homeCubit.currentIndex==1? true:false,
                onPressed: (){
                  homeCubit.changePage(index: 1);
                  homeCubit.storeLastRoute('customers');

                },
                icon: Icons.person,
                title: 'Customers',
              ),
              TabletCustomTextButton(
                isSelected: homeCubit.currentIndex==2? true:false,
                onPressed: (){
                  homeCubit.changePage(index: 2);
                   homeCubit.storeLastRoute('users');

                },
                icon: CupertinoIcons.person_3,
                title: 'Users',
              ),
              TabletCustomTextButton(
                isSelected: homeCubit.currentIndex==3? true:false,
                icon: CupertinoIcons.doc,
                title: 'Reports',
                onPressed: () {
                  homeCubit.changePage(index: 3);
                  homeCubit.storeLastRoute('reports');

                },
              ),
              TabletCustomTextButton(
                isSelected: homeCubit.currentIndex==4? true:false,
                onPressed: () {
                  homeCubit.changePage(index: 4);
                  homeCubit.storeLastRoute('bags');
                },
                icon: Icons.shopping_bag_rounded,
                title: 'Bags',
              ),
              const Spacer(flex: 2,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Divider(
                  height: 0.2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TabletCustomTextButton(
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

class TabletCustomTextButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isSelected;
  const TabletCustomTextButton(
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
      height: 50.h,
      child: TextButton(
          onPressed: onPressed ,
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 10.sp,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w200,
                    color: Colors.white),
              )
            ],
          )),
    );
  }
}
