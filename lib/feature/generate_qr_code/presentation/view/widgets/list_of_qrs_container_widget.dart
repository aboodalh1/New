import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrreader/feature/generate_qr_code/data/model/generate_qr_model.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/manger/qrs_list_to_download_cubit.dart';
class ListOfQrsContainerWidget extends StatelessWidget {
  final bool isTablet;
  final bool isMobile;
  const ListOfQrsContainerWidget(
      {super.key, required this.isTablet, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    // const double itemWidth = 70; // Adjust based on QR size
    const double itemHeight = 90; // Adjust based on QR size + text
    const double spacing = 10; // Spacing between QR items

    return BlocBuilder<QrsListToDownloadCubit, QrsListToDownloadState>(
      builder: (context, state) {
        final List<List<GenerateQrDataModel>> rows = [];
        for (int i = 0; i < state.qrList.length; i += 3) {
          rows.add(state.qrList.sublist(
              i, i + 3 > state.qrList.length ? state.qrList.length : i + 3));
        }
//Zak
        // final double containerWidth = (itemWidth * 3) + (spacing * 2);
        const double containerHeight = (itemHeight * 4) + (spacing * 3);

        return Container(
          width: state.qrList.length < 3
              ? isTablet
                  ? MediaQuery.sizeOf(context).width * 0.4
                  : isMobile
                      ? MediaQuery.sizeOf(context).width
                      : 50.w
              : null, // Width based on 3 items
          height: containerHeight, // Height based on 4 rows
          decoration: BoxDecoration(
            border: Border.all(
                width: 3, color: const Color.fromARGB(119, 184, 184, 184)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: rows.map((row) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: row.map((qrData) {
                    return Padding(
                      padding: const EdgeInsets.all(spacing / 2),
                      child: RepaintBoundary(
                        child: Column(
                          children: [
                            Container(
                              decoration:
                                  const BoxDecoration(color: Color(0xffF2F2F2)),
                              height: 50,
                              width: 50,
                              child: Center(
                                child: QrImageView(
                                  size: 50,
                                  data: qrData.qrContent,
                                  version: QrVersions.auto,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      qrData.customerName,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      'Bag ID: ${qrData.bagId}',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}