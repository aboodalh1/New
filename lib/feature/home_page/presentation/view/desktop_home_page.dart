import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/constant.dart';
import 'package:qrreader/core/util/function/navigation.dart';
import 'package:qrreader/core/widgets/desktop/desktop_custom_loading_indicator.dart';
import 'package:qrreader/feature/customers/presentation/manger/customer_cubit.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/manger/qrs_list_to_download_cubit.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/view/generate_qr_page_view.dart';
import 'package:qrreader/feature/home_page/presentation/manger/home_cubit.dart';
import 'package:qrreader/feature/home_page/presentation/view/widgets/custom_elevated_button.dart';
import 'package:qrreader/feature/messages/presentation/view/messages_page_view.dart';

import '../../../../core/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../../../../core/widgets/desktop_status_cell.dart';
import '../../../Auth/presentation/view/sign_in_page.dart';

class DesktopHomePage extends StatelessWidget {
  const DesktopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: DesktopHomePageBody(),
    );
  }
}

class DesktopHomePageBody extends StatelessWidget {
  const DesktopHomePageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetReadsFailureState) {
          if (state.error == 'Session Expired') {
            navigateAndFinish(context, const SignInPage());
          }
          customSnackBar(context, state.error);
        }
        if (state is GetReadsSuccessState) {
          customSnackBar(context, state.message);
        }
        if (state is GetReadsFailureState) {
          customSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Last Reads:",
                      style: TextStyle(fontSize: 8.sp),
                    ),
                    SizedBox(
                      width: 152.w,
                    ),
                    IconButton(
                        tooltip: 'Refresh',
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          context.read<HomeCubit>().getAllReads();
                        },
                        icon: Icon(
                          Icons.refresh,
                          size: 6.sp,
                          color: kSecondaryColor,
                        )),
                    IconButton(
                        tooltip: 'Notifications',
                        onPressed: () {
                          navigateTo(context, const MessagePageView());
                        },
                        icon: Icon(
                          Icons.notifications,
                          size: 6.sp,
                          color: kSecondaryColor,
                        )),
                    SizedBox(
                      width: 5.w,
                    ),
                    CustomElevatedButton(
                      platform: 'desktop',
                      fill: true,
                      title: 'Generate QR',
                      onPressed: () {
                        context
                            .read<CustomerCubit>()
                            .getAllCustomers(role: 'all');
                        navigateTo(
                            context,
                            BlocProvider.value(
                                value: BlocProvider.of<QrsListToDownloadCubit>(
                                    context),
                                child: const GenerateQrPageViw()));
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                state is GetReadsLoadingState
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 180.h,
                          ),
                          Text("Getting last reads",
                              style: TextStyle(
                                  fontSize: 5.sp,
                                  color: Colors.black.withOpacity(0.75))),
                          SizedBox(
                            height: 10.h,
                          ),
                          const DesktopLoadingIndicator(),
                        ],
                      )
                    : DataTable(
                        headingRowColor:
                            MaterialStateProperty.all(kPrimaryColor),
                        headingTextStyle: const TextStyle(color: Colors.white),
                        border: const TableBorder(
                          horizontalInside:
                              BorderSide(width: 0.54, color: Colors.black),
                        ),
                        columnSpacing: 10.w,
                        columns: [
                          DataColumn(
                            label: customText(
                              label: 'User name',
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
                              label: 'Customer Name',
                              color: Colors.black,
                            ),
                          ),
                          DataColumn(
                            label: customText(
                              label: 'Bag ID',
                              color: Colors.black,
                            ),
                          ),
                          DataColumn(
                            label: customText(
                              label: 'Status',
                              color: Colors.black,
                            ),
                          ),
                          DataColumn(
                            label: customText(
                              label: 'Date',
                              color: Colors.black,
                            ),
                          ),
                        ],
                        rows: List.generate(
                            context
                                .read<HomeCubit>()
                                .homeReadsModel
                                .data
                                .length,
                            (i) => DataRow(cells: [
                                  DataCell(SizedBox(
                                    width: 200,
                                    child: Text(
                                        style: TextStyle(fontSize: 3.8.sp),
                                        overflow: TextOverflow.ellipsis,
                                        context
                                            .read<HomeCubit>()
                                            .homeReadsModel
                                            .data[i]
                                            .userName),
                                  )),
                                  DataCell(Text(
                                      style: TextStyle(fontSize: 3.8.sp),
                                      context
                                          .read<HomeCubit>()
                                          .homeReadsModel
                                          .data[i]
                                          .userRole)),
                                  DataCell(SizedBox(
                                    width: 200,
                                    child: Text(
                                        style: TextStyle(fontSize: 3.8.sp),
                                        overflow: TextOverflow.ellipsis,
                                        context
                                            .read<HomeCubit>()
                                            .homeReadsModel
                                            .data[i]
                                            .customerName),
                                  )),
                                  DataCell(Text(
                                      style: TextStyle(fontSize: 3.8.sp),
                                      '${context.read<HomeCubit>().homeReadsModel.data[i].bagId}')),
                                  DataCell(DesktopStatusCell(
                                    title: context
                                                    .read<HomeCubit>()
                                                    .homeReadsModel
                                                    .data[i]
                                                    .status ==
                                                'stored_stage_1' ||
                                            context
                                                    .read<HomeCubit>()
                                                    .homeReadsModel
                                                    .data[i]
                                                    .status ==
                                                'stored_stage_2'
                                        ? 'At Store'
                                        : context
                                                        .read<HomeCubit>()
                                                        .homeReadsModel
                                                        .data[i]
                                                        .status ==
                                                    'shipping' &&
                                                context
                                                        .read<HomeCubit>()
                                                        .homeReadsModel
                                                        .data[i]
                                                        .previousState ==
                                                    "stored_stage_2"
                                            ? 'To Customer'
                                            : context
                                                            .read<HomeCubit>()
                                                            .homeReadsModel
                                                            .data[i]
                                                            .status ==
                                                        'shipping' &&
                                                    context
                                                            .read<HomeCubit>()
                                                            .homeReadsModel
                                                            .data[i]
                                                            .previousState ==
                                                        "delivered"
                                                ? "To Kitchen"
                                                : 'Delivered',
                                    color: context
                                                    .read<HomeCubit>()
                                                    .homeReadsModel
                                                    .data[i]
                                                    .status ==
                                                'stored_stage_1' ||
                                            context
                                                    .read<HomeCubit>()
                                                    .homeReadsModel
                                                    .data[i]
                                                    .status ==
                                                'stored_stage_2'
                                        ? kAtStoreColor
                                        : context
                                                    .read<HomeCubit>()
                                                    .homeReadsModel
                                                    .data[i]
                                                    .status ==
                                                'shipping'
                                            ? kOnWayColor
                                            : kAtCustomerColor,
                                  )),
                                  DataCell(Text(
                                      style: TextStyle(fontSize: 3.8.sp),
                                      context
                                          .read<HomeCubit>()
                                          .homeReadsModel
                                          .data[i]
                                          .date)),
                                ])))
              ],
            ),
          ),
        );
      },
    );
  }

  Text customText({required String label, color}) => Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: color == Colors.black ? Colors.white : kPrimaryColor,
            fontSize: 4.sp,
            fontWeight: FontWeight.w400),
      );
}

class CustomTextButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback function;
  final bool isSelected;
  const CustomTextButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.function,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: isSelected ? kSecondaryColor : kPrimaryColor),
      height: 60.h,
      child: TextButton(
          onPressed: function,
          child: Row(
            children: [
              Icon(
                icon,
                size: 22.sp,
                color: Colors.white,
              ),
              SizedBox(
                width: 10.h,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w200,
                    color: Colors.white),
              )
            ],
          )),
    );
  }
}
