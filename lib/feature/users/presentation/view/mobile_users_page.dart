import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/constant.dart';
import 'package:qrreader/core/util/function/navigation.dart';
import 'package:qrreader/feature/users/presentation/manger/user_cubit.dart';
import 'package:qrreader/feature/users/presentation/view/add_user/add_user_page_view.dart';

import '../../../home_page/presentation/view/widgets/custom_elevated_button.dart';

class MobileUsersPage extends StatelessWidget {
  const MobileUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        UserCubit userCubit = context.read<UserCubit>();
        return Scaffold(
          body: state is GetUsersLoadingState? Center(
            child: Container(
                height: 160.h,
              width: 190.w,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(15.r)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Fetching Data",style: TextStyle(color: Colors.white,fontSize: 15.sp,fontWeight: FontWeight.w700),),
                  SizedBox(height: 15.h,),
                  Center(child: CircularProgressIndicator(color: Colors.white,),),
                ],
              ),
            ),
          ): SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomElevatedButton(
                        title: 'Add User',
                        onPressed: () {
                          navigateTo(
                              context, AddUserPageView(userCubit: userCubit, isEdit: false,));
                        },
                        fill: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                        itemBuilder: (context,index)=> Container(
                          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r,),
                            border: Border.all(color: kSecondaryColor),
                          ),
                        ),
                        itemCount: userCubit.allUsersModel.data.length),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
