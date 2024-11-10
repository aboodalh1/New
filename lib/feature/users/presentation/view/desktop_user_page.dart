import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/util/function/navigation.dart';
import 'package:qrreader/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:qrreader/feature/Auth/presentation/view/sign_in_page.dart';
import 'package:qrreader/feature/home_page/presentation/view/widgets/custom_elevated_button.dart';
import 'package:qrreader/feature/home_page/presentation/view/widgets/desktop/custom_search_bar.dart';
import 'package:qrreader/feature/users/presentation/manger/user_cubit.dart';
import 'package:qrreader/feature/users/presentation/view/add_user/add_user_page_view.dart';
import '../../../../constant.dart';

class DesktopUsersPage extends StatelessWidget {
  const DesktopUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is GetUsersFailureState) {
          if (state.error == 'Session Expired') {
            navigateAndFinish(context, const SignInPage());
          }
          customSnackBar(context, state.error);
        }
        if(state is DeleteUsersSuccessState){
          if(Navigator.of(context).canPop()){
            Navigator.pop(context);
          }
          customSnackBar(context, state.message);
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
        if (state is DeleteUsersFailureState) {
          customSnackBar(context, state.error);
        }
        if (state is DeleteUsersLoadingState) {
          customSnackBar(context, 'Loading', duration: 200);
        }
      },
      builder: (context, state) {
        if (state is GetUsersLoadingState) {
          return const Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ),
          );
        }

        UserCubit userCubit = context.read<UserCubit>();
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 50, right: 20),
            child: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  GestureDetector(
                    onTap: userCubit.isExpanded
                        ? () {
                            userCubit.expandFilterButton();
                          }
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomElevatedButton(
                              title: 'Add User',
                              onPressed: () {
                                navigateTo(
                                    context,
                                    AddUserPageView(
                                      userCubit: userCubit,
                                      isEdit: false,
                                    ));
                              },
                              fill: true,
                              platform: 'desktop',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             CustomSearchBar(
                              onChanged: (String val){},
                            ),
                            SizedBox(
                              width: 40.w,
                            ),
                            CustomElevatedButton(
                              platform: 'desktop',
                              title: 'reset',
                              onPressed: () {
                                userCubit.isFiltered
                                    ? userCubit.getAllUser(role: 'all')
                                    : null;
                              },
                              fill: false,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        state is EmptyUsersState
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 20,),
                                    Text(
                                      "You didn't have any ${state.role} yet",
                                      style: TextStyle(fontSize: 7.sp),
                                    ),
                                    const SizedBox(height: 40,),
                                    TextButton(
                                      onPressed: () {
                                        navigateTo(
                                            context,
                                            AddUserPageView(
                                              userCubit: userCubit,
                                              isEdit: false,
                                            ));
                                      },
                                      child: Badge(
                                          label: const Text("Add User"),
                                          backgroundColor: kUnsubsicriber,
                                          child: Icon(
                                            Icons.person_add_alt_1_rounded,
                                            size: 20.sp,
                                            color: kSecondaryColor
                                                .withOpacity(0.5),
                                          )),
                                    ),
                                  ],
                                ),
                              )
                            : DataTable(
                                headingRowColor:
                                    MaterialStateProperty.all(kPrimaryColor),
                                headingTextStyle:
                                    const TextStyle(color: Colors.white),
                                border: const TableBorder(
                                  horizontalInside: BorderSide(
                                      width: 0.54, color: Colors.black),
                                ),
                                columnSpacing: 45.w,
                                columns: [
                                  DataColumn(
                                    label: customText(
                                      label: 'User Name',
                                      color: Colors.black,
                                    ),
                                  ),
                                  DataColumn(
                                    label: customText(
                                      label: 'Phone Number',
                                      color: Colors.black,
                                    ),
                                  ),
                                  DataColumn(
                                    label: customText(
                                      label: 'Position',
                                      color: Colors.black,
                                    ),
                                  ),
                                  DataColumn(
                                    label: customText(
                                      label: 'Actions',
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                                rows: userCubit.rows)
                      ],
                    ),
                  ),
                  Positioned(
                    top: 70,
                    right: 80.w,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            userCubit.expandFilterButton();
                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              overlayColor: MaterialStateProperty.all(
                                  Colors.black.withOpacity(0.25)),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 4.h)),
                              backgroundColor: MaterialStateProperty.all(
                                  userCubit.isFiltered
                                      ? kPrimaryColor
                                      : const Color(0xffFFFFFF)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1.6, color: kPrimaryColor),
                                  borderRadius: userCubit.isExpanded
                                      ? BorderRadius.only(
                                          topLeft: Radius.circular(11.r),
                                          topRight: Radius.circular(11.r),
                                        )
                                      : BorderRadius.circular(11.r),
                                ),
                              )),
                          child: Text(
                            'Filter',
                            style: TextStyle(
                                fontSize: 4.sp,
                                fontWeight: FontWeight.w300,
                                color: userCubit.isFiltered
                                    ? Colors.white
                                    : kPrimaryColor),
                          ),
                        ),
                        userCubit.isExpanded
                            ? Container(
                                height: 120.h,
                                width: 24.5.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(11.r),
                                        bottomRight: Radius.circular(11.r)),
                                    border: Border.all(
                                        color: kPrimaryColor, width: 1.8)),
                                child: Column(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          userCubit.getAllUser(role: 'driver');
                                        },
                                        child: Text(
                                          "Drivers",
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 3.sp),
                                        )),
                                    const Divider(),
                                    TextButton(
                                        onPressed: () {
                                          userCubit.getAllUser(role: 'worker');
                                        },
                                        child: Text(
                                          "Worker",
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 3.sp),
                                        )),
                                    const Divider(),
                                    TextButton(
                                        onPressed: () {
                                          userCubit.getAllUser(role: 'admin');
                                        },
                                        child: Text(
                                          "Admins",
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 3.sp),
                                        )),
                                  ],
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Text customText({required String label, color}) => Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: color == Colors.black ? Colors.white : kPrimaryColor,
            fontSize: 4.sp,
            fontWeight: FontWeight.w400),
      );
}

class CustomDeleteTextButton extends StatelessWidget {
  const CustomDeleteTextButton(
      {super.key,
      required this.i,
      required this.userCubit,
      required this.isTablet});

  final int i;
  final UserCubit userCubit;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  "Are you sure you want to delete ${userCubit.allUsersModel.data[i].name}\n  and all related information?",
                  style: TextStyle(
                      fontSize: isTablet ? 5.sp : 4.sp, color: Colors.black),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        userCubit.deleteUser(
                            id: userCubit.allUsersModel.data[i].id);
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(
                            color: kOnWayColor,
                            fontSize: isTablet ? 4.5.sp : 3.5.sp),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: isTablet ? 4.5.sp : 3.5.sp),
                      )),
                ],
              );
            });
      },
      child: Text(
        "Delete",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: kOnWayColor,
            fontSize: isTablet ? 6.sp : 4.sp,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

class CustomEditTextButton extends StatelessWidget {
  final UserCubit userCubit;
  final int i;
  final bool isTablet;

  const CustomEditTextButton(
      {super.key,
      required this.userCubit,
      required this.i,
      required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        userCubit.fullNameController.text =
            userCubit.allUsersModel.data[i].name;
        userCubit.phoneNumberController.text =
            userCubit.allUsersModel.data[i].phone;
        userCubit.imageController.text =
            userCubit.allUsersModel.data[i].image??'';
        userCubit.selectedJob = userCubit.allUsersModel.data[i].role;
        userCubit.editID = userCubit.allUsersModel.data[i].id;
        navigateTo(
            context,
            AddUserPageView(
              userCubit: userCubit,
              isEdit: true,
            ));
      },
      child: Text(
        "Edit",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: kUnsubsicriber,
            fontSize: isTablet ? 6.sp : 4.sp,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
