import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/core/util/function/navigation.dart';
import 'package:qrreader/feature/users/presentation/manger/user_cubit.dart';
import 'package:qrreader/feature/users/presentation/view/add_user/add_user_page_view.dart';

import '../../../../constant.dart';
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
                  SizedBox(
                    width: 20.w,
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
              userCubit.allUsersModel.data.isEmpty?
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
                  rows: List.generate(userCubit.allUsersModel.data.length, (index) {
                    return DataRow(cells: [
                      DataCell(SizedBox(
                          width: 86.w,
                          child: Text(
                            maxLines: 2,
                            textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              context.read<UserCubit>().allUsersModel.data[index].name))),
                      DataCell(Text(context.read<UserCubit>().allUsersModel.data[index].phone)),
                      DataCell(Text(context.read<UserCubit>().allUsersModel.data[index].role)),
                      DataCell(Row(
                        children: [
                          CustomDeleteTextButton(userCubit: context.read<UserCubit>(), i:index,isTablet: true,),
                          CustomEditTextButton(userCubit: context.read<UserCubit>(), i: index,isTablet: true,)
                        ],
                      )),
                    ]);
                  }))
            ],
          ),
        ),
      ),
    );
  },
);
  }
}


