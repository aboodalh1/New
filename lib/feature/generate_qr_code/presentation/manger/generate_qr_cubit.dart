import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qrreader/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:qrreader/feature/generate_qr_code/data/model/generate_qr_model.dart';
import 'package:qrreader/feature/generate_qr_code/data/repos/generate_qr_repo.dart';
import 'package:qrreader/feature/generate_qr_code/presentation/manger/qrs_list_to_download_cubit.dart';
import 'dart:html' as html;
import 'dart:typed_data';

import '../../../../constant.dart';
part 'generate_qr_state.dart';

class GenerateQrCubit extends Cubit<GenerateQrState> {
  GenerateQrCubit(this.generateQrRepo) : super(GenerateQrcubitInitial());
  bool isGenerateQr = false;
  GenerateQrRepo generateQrRepo;
  String? qrData;
  GlobalKey globalKey = GlobalKey();
  GenerateQrModel generateQrModel = GenerateQrModel(
      code: 1,
      message: 'message',
      data: GenerateQrDataModel(
          qrContent: 'qrContent', customerName: 'customerName', bagId: 1));
  String qrContainer = '';

  // Future<void> printContainer(
  //     {required String name, required num bagID}) async {
  //   Future.delayed(const Duration(milliseconds: 500), () async {
  //     emit(PrintContainerLoadingState());
  //     try {
  //       RenderRepaintBoundary boundary = globalKey.currentContext!
  //           .findRenderObject() as RenderRepaintBoundary;
  //       final image = await boundary.toImage(pixelRatio: 3.0);
  //       final byteData = await image.toByteData(format: ImageByteFormat.png);
  //       final pngBytes = byteData!.buffer.asUint8List();
  //       final pdf = pw.Document();
  //       final imagePdf = pw.MemoryImage(pngBytes);
  //       pdf.addPage(
  //         pw.Page(
  //           build: (pw.Context context) => pw.Center(child: pw.Image(imagePdf)),
  //         ),
  //       );
  //       final Uint8List pdfBytes = await pdf.save();
  //       final blob = html.Blob([pdfBytes], 'application/pdf');
  //       final url = html.Url.createObjectUrlFromBlob(blob);
  //       final anchor = html.AnchorElement(href: url)
  //         ..setAttribute("download", "$name, $bagID.pdf")
  //         ..click();
  //       html.Url.revokeObjectUrl(url);
  //       emit(PrintContainerSuccessState(message: 'Saved Successfully'));
  //     } catch (e) {
  //       emit(PrintContainerFailureState(error: 'Something went wrong'));
  //     }
  //   });
  // }
  Future<void> printContainer(BuildContext context) async {
    emit(PrintContainerLoadingState());
    try {
      final List<GenerateQrDataModel> qrList =
          BlocProvider.of<QrsListToDownloadCubit>(context).state.qrList;

      if (qrList.isEmpty) {
        emit(PrintContainerFailureState(
            error: 'No QR codes available to print.'));
        return;
      }
// Load the Arabic font
      final ByteData fontData =
          await rootBundle.load('assets/fonts/Tajawal-Bold.ttf');
      final pw.Font arabicFont = pw.Font.ttf(fontData);

      final pdf = pw.Document();
      const int itemsPerRow = 3;
      const int rowsPerPage = 4;
      const int itemsPerPage = itemsPerRow * rowsPerPage;

      for (int i = 0; i < qrList.length; i += itemsPerPage) {
        final currentPageItems = qrList.sublist(
            i,
            i + itemsPerPage > qrList.length
                ? qrList.length
                : i + itemsPerPage);

        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    for (int j = 0;
                        j < currentPageItems.length;
                        j += itemsPerRow) ...[
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int k = 0; k < itemsPerRow; k++)
                            if (j + k < currentPageItems.length)
                              _buildQrItem(currentPageItems[j + k], arabicFont),
                        ],
                      ),
                      if (j + itemsPerRow < currentPageItems.length)
                        pw.SizedBox(
                            height:
                                20), // Add spacing after each row except last
                    ],
                  ]);
            },
          ),
        );
      }

      final Uint8List pdfBytes = await pdf.save();
      final blob = html.Blob([pdfBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "QRCodes.pdf")
        ..click();
      html.Url.revokeObjectUrl(url);

      emit(PrintContainerSuccessState(message: 'PDF saved successfully.'));
    } catch (e) {
      emit(PrintContainerFailureState(error: 'Something went wrong.'));
    }
  }

  // pw.Widget _buildQrItem(GenerateQrDataModel qrData) {
  //   return pw.Column(
  //     children: [
  //       pw.Container(
  //         width: 90,
  //         height: 90,
  //         decoration: pw.BoxDecoration(
  //           border: pw.Border.all(color: PdfColors.black),
  //         ),
  //         child: pw.Center(
  //           child: pw.BarcodeWidget(
  //             barcode: pw.Barcode.qrCode(),
  //             data: qrData.qrContent,
  //             width: 70,
  //             height: 70,
  //           ),
  //         ),
  //       ),
  //       pw.SizedBox(height: 5),
  //       //zak
  //       pw.Text("${qrData.customerName}", style: pw.TextStyle(fontSize: 10)),
  //       // pw.Text("${qrData.customerName}, Customer Id:${qrData.}", style: pw.TextStyle(fontSize: 10)),
  //       pw.Text("Bag ID: ${qrData.bagId}", style: pw.TextStyle(fontSize: 10)),
  //     ],
  //   );
  // }
  pw.Widget _buildQrItem(GenerateQrDataModel qrData, pw.Font arabicFont) {
    return pw.Column(
      children: [
        pw.Container(
          width: 90,
          height: 90,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.black),
          ),
          child: pw.Center(
            child: pw.BarcodeWidget(
              barcode: pw.Barcode.qrCode(),
              data: qrData.qrContent,
              width: 70,
              height: 70,
            ),
          ),
        ),
        pw.SizedBox(height: 5),

        // Properly Wrap the Customer Name
        pw.Text(
          _splitLongText(qrData.customerName),
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(font: arabicFont, fontSize: 10),
        ),

        pw.Text(
          "Bag ID: ${qrData.bagId}",
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  String _splitLongText(String text) {
    const int maxCharsPerLine = 22;
    List<String> lines = [];

    for (int i = 0; i < text.length; i += maxCharsPerLine) {
      lines.add(text.substring(
          i,
          i + maxCharsPerLine > text.length
              ? text.length
              : i + maxCharsPerLine));
    }

    return lines
        .join('\n'); // Each line will be displayed separately in the PDF
  }

  void generateQrSecond(context) async {
    if (selectedCustomer.isEmpty) {
      customSnackBar(context, 'Select customer please!');
    } else {
      qrData = qrContainer;
      isGenerateQr = true;
      emit(GenerateNewQrState());
    }
  }

  void clearQr() {
    selectedCustomer = '';
    isGenerateQr = false;
    emit(ClearQrState());
  }

  Future<void> generateQR(context, {required int i}) async {
    emit(GenerateQrLoadingState());
    var result = await generateQrRepo.generateQr(
        customerID: customersMap[selectedCustomer.split(',').first.trim()]!);
    result.fold((failure) {
      emit(GenerateQrFailureState(error: failure.errMessage));
    }, (response) {
      generateQrModel = GenerateQrModel.fromJson(response.data);
      qrContainer = generateQrModel.data.qrContent;
      generateQrSecond(context);
      emit(GenerateQrSuccessState(message: generateQrModel.message));
    });
  }

  String selectedCustomer = '';
}
