import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/util/function/navigation.dart';
import 'package:qrreader/feature/users/presentation/manger/user_cubit.dart';
import 'package:qrreader/feature/users/presentation/view/add_user/add_user_page_view.dart';

import '../../../../constant.dart';
import '../../../../core/util/screen_util.dart';
import '../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../../../core/widgets/tablet/tablet_custom_loading_indicator.dart';
import '../../../Auth/presentation/view/sign_in_page.dart';
import '../../../home_page/presentation/view/tablet_home_page.dart';
import '../../../home_page/presentation/view/widgets/custom_elevated_button.dart';
import 'desktop_user_page.dart';
class TabletUsersPage extends StatelessWidget {
  const TabletUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
  listener: (context, state) {
    if (state is GetUsersFailureState ) {
      if(state.error=='Session Expired'){
        navigateAndFinish(context, const SignInPage());
      }
      customSnackBar(context, state.error);
    }
    if(state is GetUsersSuccessState){
      for (int i = 0; i < context.read<UserCubit>().allUsersModel.data.length; i++) {
      if(context.read<UserCubit>().allUsersModel.data[i].id==1)continue;
        context.read<UserCubit>().rows.add(DataRow(cells: [
          DataCell(Text(context.read<UserCubit>().allUsersModel.data[i].name)),
          DataCell(Text(context.read<UserCubit>().allUsersModel.data[i].phone)),
          DataCell(Text(context.read<UserCubit>().allUsersModel.data[i].role)),
          DataCell(Row(
            children: [
              CustomDeleteTextButton(userCubit: context.read<UserCubit>(), i:i,isTablet: true,),
              CustomEditTextButton(userCubit: context.read<UserCubit>(), i: i,isTablet: true,)
            ],
          )),
        ]));
      }
    }
  },
  builder: (context, state) {
    if(state is GetUsersLoadingState){
      return const TabletLoadingIndicator();}
    UserCubit userCubit = context.read<UserCubit>();
    return Scaffold(
      body: SingleChildScrollView(
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
                      navigateTo(context, AddUserPageView(userCubit: userCubit, isEdit: false));
                    },
                    fill: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width:ScreenSizeUtil.screenWidth*0.3,height:ScreenSizeUtil.screenWidth/20,child: SearchBar(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    elevation: MaterialStateProperty.all(0),
                    leading: const Icon(Icons.search),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    side: MaterialStateProperty.all(const BorderSide(color: Colors.black,width: 0.7)),
                  )),
                  const SizedBox(
                    width: 20,
                  ),
                  CustomElevatedButton(
                    title: 'Filter',
                    onPressed: () {},
                    fill: false,
                  )
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              userCubit.rows.isEmpty?
                  const Center(child: Text("You Don't have users yet")):
              DataTable(
                  headingRowColor: MaterialStateProperty.all(kPrimaryColor),
                  headingTextStyle: const TextStyle(color: Colors.white),
                  border: const TableBorder(
                    horizontalInside: BorderSide(width: 0.54, color: Colors.black),
                  ),
                  columnSpacing: 40.w,
                  columns: const [
                    DataColumn(
                      label: TabletCustomText(
                        title: 'User Name',
                        isHeader: true,
                      ),
                    ),
                    DataColumn(
                      label: TabletCustomText(
                        title: 'Phone Number',
                        isHeader: true,
                      ),
                    ),
                    DataColumn(
                      label: TabletCustomText(
                        title: 'Position',
                        isHeader: true,
                      ),
                    ),  DataColumn(
                      label: TabletCustomText(
                        title: 'Actions',
                        isHeader: true,
                      ),
                    ),
                  ],
                  rows: userCubit.rows)
            ],
          ),
        ),
      ),
    );
  },
);
  }
}


