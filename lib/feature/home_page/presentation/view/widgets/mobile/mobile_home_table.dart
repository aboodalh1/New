import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../constant.dart';
import '../../../../../../core/widgets/mobile/mobile_status_cell.dart';
import '../../../manger/home_cubit.dart';
import 'mobile_custom_text.dart';

class MobileHomeTable extends StatelessWidget {
  MobileHomeTable({
    super.key,
    required this.homeCubit,
  });
  final TransformationController transformationController =
  TransformationController();
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: transformationController,
      minScale: 0.1,
      maxScale: 2.5,
      child: DataTable(
          headingRowHeight: 20,
          dataRowHeight: 25,
          headingRowColor: MaterialStateProperty.all(kPrimaryColor),
          headingTextStyle: const TextStyle(color: Colors.white),
          border: const TableBorder(
            horizontalInside:
            BorderSide(width: 0.54, color: Colors.black),
          ),
            columnSpacing: 5.w,
          columns: const [
            DataColumn(
                label: MobileCustomText(title: 'User name', isHeader: true,)),
            DataColumn(
                label: MobileCustomText(title: 'Position', isHeader: true,)),
            DataColumn(
                label: MobileCustomText(title: 'Customer Name', isHeader: true,)),
            DataColumn(
                label: MobileCustomText(title: 'Bag ID', isHeader: true,)),
            DataColumn(
                label: MobileCustomText(title: 'Status', isHeader: true,)),
            DataColumn(
                label: MobileCustomText(title: 'Date', isHeader: true,)),
          ],
          rows:  List.generate(homeCubit.homeReadsModel.data.length, (i) =>DataRow(cells: [
            DataCell(MobileCustomText(
                isHeader: false,
                title: homeCubit
                    .homeReadsModel
                    .data[i]
                    .userName)),
            DataCell(MobileCustomText(
                isHeader: false,
                title: homeCubit.homeReadsModel
                    .data[i]
                    .userRole)),
            DataCell(MobileCustomText(
                isHeader: false,
                title: homeCubit
                    .homeReadsModel
                    .data[i]
                    .customerName)),
            DataCell(MobileCustomText(
                isHeader: false,
                title:
                '${homeCubit.homeReadsModel.data[i].bagId}')),
            DataCell(MobileStatusCell(
              title: homeCubit
                  .homeReadsModel
                  .data[i]
                  .status ==
                  'stored_stage_1' ||
                  homeCubit
                      .homeReadsModel
                      .data[i]
                      .status ==
                      'stored_stage_2'
                  ? 'At Store'
                  : homeCubit
                  .homeReadsModel
                  .data[i]
                  .status ==
                  'shipping'
                  ? 'On Way'
                  : 'Delivered',
              color: homeCubit
                  .homeReadsModel
                  .data[i]
                  .status ==
                  'stored_stage_1' ||
                  homeCubit
                      .homeReadsModel
                      .data[i]
                      .status ==
                      'stored_stage_2'
                  ? kAtStoreColor
                  : homeCubit
                  .homeReadsModel
                  .data[i]
                  .status ==
                  'shipping'
                  ? kOnWayColor
                  : kAtCustomerColor,
            )),
            DataCell(MobileCustomText(
                isHeader: false,
                title: homeCubit
                    .homeReadsModel
                    .data[i]
                    .date)),
          ]))),
    );
  }
}
