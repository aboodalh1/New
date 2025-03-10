import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/constant.dart';
import 'package:qrreader/core/util/function/navigation.dart';
import 'package:qrreader/feature/users/presentation/manger/user_cubit.dart';
import 'package:qrreader/feature/users/presentation/view/add_user/add_user_page_view.dart';


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
                  const Center(child: CircularProgressIndicator(color: Colors.white,),),
                ],
              ),
            ),
          ): SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            navigateTo(
                                context, AddUserPageView(userCubit: userCubit, isEdit: false,));
                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.25)),
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 5.w,vertical: 4.h)),
                              backgroundColor: MaterialStateProperty.all(kSecondaryColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  side: const BorderSide(width: 1.6,color: kSecondaryColor),
                                  borderRadius: BorderRadius.circular(11.r),
                                ),
                              )),
                          child:  Text(
                            'Add User',
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w300, color: Colors.white),
                          ),
                        )

                      ],
                    ),
                  ),
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                        itemBuilder: (context,index)=> Container(
                          margin:  const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          height: 110,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r,),
                            border: Border.all(color: kSecondaryColor),
                          ),
                          child: Row(
                            children: [
                              userCubit.allUsersModel.data[index].image!=''? SizedBox(
                                height: 80,
                                width: 60.w,
                                child: FancyShimmerImage(
                                  boxFit: BoxFit.cover,
                                  imageUrl: '${userCubit.allUsersModel.data[index].image}',
                                ),
                              ):Image.asset("assets/img/person.png",height: 80,width: 60.w,),
                              SizedBox(width: 10.w,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:120.w,
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        userCubit.allUsersModel.data[index].name,style: TextStyle(
                                        fontSize: 10.sp
                                      ),),
                                    ),
                                    SizedBox(height:5.h),
                                    Text('Role: ${userCubit.allUsersModel.data[index].role}',style: TextStyle(
                                      fontSize: 10.sp
                                    ),),
                                    SizedBox(height:5.h),
                                    Text('Phone: ${userCubit.allUsersModel.data[index].phone}',style: TextStyle(
                                      fontSize: 10.sp
                                    ),),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(EdgeInsets.zero)
                                        ),
                                          padding: EdgeInsets.zero,
                                          iconSize: 20.sp,
                                          onPressed: (){
                                        userCubit.fullNameController.text =
                                            userCubit.allUsersModel.data[index].name;
                                        userCubit.phoneNumberController.text =
                                            userCubit.allUsersModel.data[index].phone;
                                        userCubit.imageController.text =
                                            userCubit.allUsersModel.data[index].image??'';
                                        userCubit.selectedJob = userCubit.allUsersModel.data[index].role;
                                        userCubit.editID = userCubit.allUsersModel.data[index].id;
                                        navigateTo(
                                            context,
                                            AddUserPageView(
                                              userCubit: userCubit,
                                              isEdit: true,
                                            ));
                                      }, icon: const Icon(Icons.edit,color: kPrimaryColor,)),
                                      IconButton(
                                          style: ButtonStyle(
                                              padding: MaterialStateProperty.all(EdgeInsets.zero)
                                          ),
                                        padding: EdgeInsets.zero,
                                          iconSize: 20.sp,
                                          onPressed: (){
                                        showDialog(context: context, builder: (context)=>AlertDialog(backgroundColor: Colors.white,

                                          title: Text("Are you sure you want to delete this user?",style: TextStyle(color: Colors.black,fontSize: 15.sp),),
                                          actions: [
                                            TextButton(onPressed: (){
                                              Navigator.of(context).pop();
                                            }, child: const Text("Cancel",style: TextStyle(color: Colors.black),)),
                                            TextButton(onPressed: (){
                                              userCubit.deleteUser(id:userCubit.allUsersModel.data[index].id );
                                              Navigator.of(context).pop();
                                            }, child: const Text("Yes",style: TextStyle(color: kOnWayColor),))]));
                                      }, icon: const Icon(Icons.person_off,color: Colors.red,)),
                                    ],
                                  )
                                ],
                              )
                            ],
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
