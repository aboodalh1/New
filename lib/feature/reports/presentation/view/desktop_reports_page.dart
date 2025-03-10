import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/constant.dart';
import 'package:qrreader/core/util/asset_loader.dart';
import 'package:qrreader/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:qrreader/feature/home_page/presentation/view/widgets/custom_elevated_button.dart';
import 'package:qrreader/feature/reports/data/repos/pdf_service.dart';
import 'package:qrreader/feature/reports/presentation/manger/reports_cubit.dart';
import 'package:qrreader/feature/reports/presentation/view/widgets/desktop/desktop_bag_status_card.dart';
import '../../../../core/widgets/desktop/desktop_custom_tablet_text.dart';
import '../../../../core/widgets/desktop_status_cell.dart';

class DesktopReportsPage extends StatelessWidget {
  const DesktopReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //===========Zak-======
    String? platform = 'desktop';
    //===========Zak-======

    return BlocConsumer<ReportsCubit, ReportsState>(
      listener: (context, state) {
        if (state is FutureDateErrorState) {
          customSnackBar(context, state.message, color: Colors.red);
        }
        if (state is GetReportsSuccessState) {
          context.read<ReportsCubit>().desktopRows = [];
          context.read<ReportsCubit>().tableData =
              context.read<ReportsCubit>().allReportsModel.data.table;
          for (int i = 0;
              i <
                  context
                      .read<ReportsCubit>()
                      .allReportsModel
                      .data
                      .table
                      .length;
              i++) {
            for (int j = 0;
                j <
                    context
                        .read<ReportsCubit>()
                        .allReportsModel
                        .data
                        .table[i]
                        .data
                        .length;
                j++) {
              context.read<ReportsCubit>().desktopRows.add(DataRow(cells: [
                    DataCell(SizedBox(
                      width: 45.w,
                      child: DesktopCustomRowText(
                        title: context
                            .read<ReportsCubit>()
                            .allReportsModel
                            .data
                            .table[i]
                            .data[j]
                            .driverName,
                      ),
                    )),
                    DataCell(SizedBox(
                      width: 45.w,
                      child: DesktopCustomRowText(
                        title: context
                            .read<ReportsCubit>()
                            .allReportsModel
                            .data
                            .table[i]
                            .customerName,
                      ),
                    )),
                DataCell(SizedBox(
                  width: 10.w,
                  child: DesktopCustomRowText(
                        title: context
                            .read<ReportsCubit>()
                            .allReportsModel
                            .data
                            .table[i]
                            .data[j].bagId.toString(),
                      ),
                )),
                    DataCell(
                      SizedBox(
                        width: 25.w,
                        child: DesktopStatusCell(
                          title: context
                                          .read<ReportsCubit>()
                                          .allReportsModel
                                          .data
                                          .table[i]
                                          .data[j]
                                          .bagState ==
                                      'stored_stage_1' ||
                                  context
                                          .read<ReportsCubit>()
                                          .allReportsModel
                                          .data
                                          .table[i]
                                          .data[j]
                                          .bagState ==
                                      'stored_stage_2'
                              ? 'At Store'
                              : context
                                          .read<ReportsCubit>()
                                          .allReportsModel
                                          .data
                                          .table[i]
                                          .data[j]
                                          .bagState ==
                                      'shipping'
                                  ? 'On Way'
                                  : 'Delivered',
                          color: context
                                          .read<ReportsCubit>()
                                          .allReportsModel
                                          .data
                                          .table[i]
                                          .data[j]
                                          .bagState ==
                                      'stored_stage_1' ||
                                  context
                                          .read<ReportsCubit>()
                                          .allReportsModel
                                          .data
                                          .table[i]
                                          .data[j]
                                          .bagState ==
                                      'stored_stage_2'
                              ? kAtStoreColor
                              : context
                                          .read<ReportsCubit>()
                                          .allReportsModel
                                          .data
                                          .table[i]
                                          .data[j]
                                          .bagState ==
                                      'shipping'
                                  ? kOnWayColor
                                  : kAtCustomerColor,
                        ),
                      ),
                    ),
                    DataCell(SizedBox(
                      width: 45.w,
                      child: DesktopCustomRowText(
                        title: context
                            .read<ReportsCubit>()
                            .allReportsModel
                            .data
                            .table[i]
                            .data[j]
                            .date,
                      ),
                    ))
                  ]));
            }
          }
        }
      },
      builder: (context, state) {
        //===================Zak=============

        // // Add more conditions here for other states if needed
        // return Container(); // Your other widget

        //===================Zak=============
        if (state is GetReportsFailureState) {
          return Scaffold(
              body: Center(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Something went wrong",
                style: TextStyle(
                  fontSize: 5.sp,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kSecondaryColor),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 8.h))),
                  onPressed: () {
                    context.read<ReportsCubit>().getAllReports();
                  },
                  child: const Text(
                    "Try again",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )));
        }
        ReportsCubit reportsCubit = context.read<ReportsCubit>();
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20),
          //=============Zak=======
          //I add a stack and add the pdf button
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 60.w,
                          child: TextFormField(
                            readOnly: true,
                            controller: reportsCubit.dateController,
                            cursorColor: kPrimaryColor,
                            style: const TextStyle(color: Colors.black),
                            onTap: () => reportsCubit.selectDate(context),
                            decoration: const InputDecoration(
                                focusColor: kPrimaryColor,
                                hoverColor: kPrimaryColor,
                                focusedBorder: UnderlineInputBorder(
                                   borderSide: BorderSide(color: kPrimaryColor)
                                ),
                                hintText: 'Select Date',
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: kPrimaryColor)),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: kPrimaryColor)),
                                suffixIcon: Icon(
                                  Icons.calendar_month_outlined,
                                  color: kPrimaryColor,
                                )),
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        DesktopBagsStatusCard(
                          title: 'At Store',
                          image: AssetsLoader.bags,
                          bagsNumber: state is GetReportsLoadingState
                              ? 'Loading...'
                              : '${reportsCubit.allReportsModel.data.cards.storedStage_1 + reportsCubit.allReportsModel.data.cards.storedStage_2}',
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        DesktopBagsStatusCard(
                          title: 'At Customer',
                          image: AssetsLoader.customerEmp,
                          bagsNumber: state is GetReportsLoadingState
                              ? 'Loading...'
                              : '${reportsCubit.allReportsModel.data.cards.delivered}',
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        DesktopBagsStatusCard(
                          title: 'Delivered',
                          bagsNumber: state is GetReportsLoadingState
                              ? 'Loading...'
                              : '${reportsCubit.allReportsModel.data.cards.shipping}',
                          image: AssetsLoader.driver,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //==========================Zak=====================
                    Container(
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(11.r),
                          // border: Border.all(width: 1.6, color: kPrimaryColor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(0, 2.8),
                              blurRadius: 4.81.r,
                            )
                          ],
                        ),
                        width: 245.w,
                        height: 40,
                        child: Text(
                          "Reports",
                          style: TextStyle(
                              fontSize: platform == 'desktop' ? 4.sp : 7.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        )
                        ),
                    //==========================Zak=====================
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 250.w,
                      height: 0.34,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    state is GetReportsLoadingState
                        ? SizedBox(
                            width: 100.w,
                            height: 100.h,
                            child: Center(
                              child: Column(
                                children: [
                                  const CircularProgressIndicator(
                                    color: kPrimaryColor,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    "Getting reports...",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 5.sp),
                                  )
                                ],
                              ),
                            ),
                          )
                        : reportsCubit.desktopRows.isEmpty
                            ? Center(
                                child: Text(
                                'You didn\'t have any scanning process this day',
                                style: TextStyle(fontSize: 5.sp),
                              ))
                            : DataTable(
                                border: const TableBorder(
                                  horizontalInside: BorderSide(
                                      width: 0.54, color: Colors.black),
                                ),
                                dataRowHeight: 42.h,
                                headingRowHeight: 30,
                                columnSpacing: 6.w,
                                headingRowColor:
                                    WidgetStateProperty.all(kPrimaryColor),
                                columns: const [
                                  DataColumn(
                                      label: DesktopCustomColumnText(
                                    title: 'Driver Name',
                                  )),
                                  DataColumn(
                                      label: DesktopCustomColumnText(
                                    title: 'Customer Name',
                                  )),
                                  DataColumn(
                                      label: DesktopCustomColumnText(
                                    title: 'Bag ID',
                                  )),
                                  DataColumn(
                                      label: DesktopCustomColumnText(
                                    title: "Status",
                                  )),
                                  DataColumn(
                                      label: DesktopCustomColumnText(
                                    title: "Date",
                                  )),
                                ],
                                rows: reportsCubit.desktopRows,
                              )
                  ],
                ),
              ),
              //======Zak====
              Positioned(
                bottom: 0,
                right: 0,
                child: CustomElevatedButton(
                  title: "Export PDF",
                  onPressed: () async {
                    //==============Zak===============
                    // reportsCubit.printTable();
                    await PdfReportService(reportsCubit: reportsCubit)
                        .printCustomersPdf();

                    //==============Zak===============
                  },
                  fill: true,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
