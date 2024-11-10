import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qrreader/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:qrreader/feature/generate_qr_code/data/model/generate_qr_model.dart';
import 'package:qrreader/feature/generate_qr_code/data/repos/generate_qr_repo.dart';
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
      data:
          Data(qrContent: 'qrContent', customerName: 'customerName', bagId: 1));
  String qrContainer = '';


  Future<void> printContainer(
      {required String name, required num bagID}) async {
    emit(PrintContainerLoadingState()); // Emit loading state
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();
      final pdf = pw.Document();
      final imagePdf = pw.MemoryImage(pngBytes);
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(child: pw.Image(imagePdf)),
        ),
      );
      final Uint8List pdfBytes = await pdf.save();
      final blob = html.Blob([pdfBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "$name, $bagID.pdf")
        ..click();
      html.Url.revokeObjectUrl(url);
      emit(PrintContainerSuccessState(message: 'Saved Successfully'));
    } catch (e) {
      emit(PrintContainerFailureState(
          error: 'Something went wrong'));
    }
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
