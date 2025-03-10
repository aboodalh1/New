import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrreader/feature/home_page/presentation/view/widgets/mobile/mobile_custom_text.dart';
import 'package:qrreader/feature/reports/presentation/manger/reports_cubit.dart';
import 'package:qrreader/feature/reports/presentation/view/widgets/tablet/tablet_bag_status_card.dart';

import '../../../../constant.dart';
import '../../../../core/util/asset_loader.dart';
import '../../../../core/widgets/tablet/tablet_status_cell.dart';

class MobileReportsPage extends StatelessWidget {
  const MobileReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReportsCubit, ReportsState>(
      listener: (context, state) {
        if (state is GetReportsSuccessState) {
          context.read<ReportsCubit>().tabletRows = [];
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
              context.read<ReportsCubit>().tabletRows.add(DataRow(cells: [
                DataCell(MobileCustomText(
                  title: context
                      .read<ReportsCubit>()
                      .allReportsModel
                      .data
                      .table[i]
                      .data[j]
                      .driverName, isHeader: false,
                )),
                DataCell(MobileCustomText(
                  title: context
                      .read<ReportsCubit>()
                      .allReportsModel
                      .data
                      .table[i]
                      .customerName, isHeader: false,
                )), DataCell(MobileCustomText(
                  title: context
                      .read<ReportsCubit>()
                      .allReportsModel
                      .data
                      .table[i]
                      .data[j].bagId.toString(), isHeader: false,
                )),
                DataCell(
                  TabletStatusCell(
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
                DataCell(MobileCustomText(
                  isHeader: false,
                  title: context
                      .read<ReportsCubit>()
                      .allReportsModel
                      .data
                      .table[i]
                      .data[j]
                      .date,
                ))
              ]));
            }
          }
        }

      },
      builder: (context, state) {
        ReportsCubit reportsCubit = context.read<ReportsCubit>();
        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 80.w,
                      child: TextFormField(
                        readOnly: true,
                        controller: reportsCubit.dateController,
                        cursorColor: kPrimaryColor,
                        style: TextStyle(color: Colors.black, fontSize: 6.sp),
                        onTap: () => reportsCubit.selectDate(context),
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor)),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TabletBagsStatusCard(
                      platform: 'mobile',
                      title: 'At Store',
                      image: AssetsLoader.bags,
                      bagsNumber: state is GetReportsLoadingState
                          ? 'Loading...'
                          : '${reportsCubit.allReportsModel.data.cards.storedStage_1 + reportsCubit.allReportsModel.data.cards.storedStage_2}',
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    TabletBagsStatusCard(
                      platform: 'mobile',
                      title: 'At Customer',
                      image: AssetsLoader.customerEmp,
                      bagsNumber: state is GetReportsLoadingState
                          ? 'Loading...'
                          : '${reportsCubit.allReportsModel.data.cards.delivered}',
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    TabletBagsStatusCard(
                      platform: 'mobile',
                      title: 'On way',
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
                    width: 290.w,
                    height: 30,
                    child: Text(
                      "Reports",
                      style: TextStyle(
                          fontSize:  7.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    )
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: 290.w,
                  height: 0.34,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 40,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      border: const TableBorder(
                        horizontalInside:
                        BorderSide(width: 0.54, color: Colors.black),
                      ),
                      dataRowHeight: 30,
                      headingRowHeight: 30,
                      columnSpacing: 25.w,
                      headingRowColor: MaterialStateProperty.all(kPrimaryColor),
                      columns: const [
                        DataColumn(
                          label: MobileCustomText(
                            isHeader: true,
                            title: "Driver Name",
                          ),
                        ),
                        DataColumn(
                          label: MobileCustomText(
                            isHeader: true,
                            title: 'Customer Name',
                          ),
                        ), DataColumn(
                          label: MobileCustomText(
                            isHeader: true,
                            title: 'Bag ID',
                          ),
                        ),
                        DataColumn(
                          label: MobileCustomText(
                            isHeader: true,
                            title: "Status",
                          ),
                        ),
                        DataColumn(
                          label: MobileCustomText(
                            isHeader: true,
                            title: "Date",
                          ),
                        ),
                      ],
                      rows:reportsCubit.tabletRows
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
