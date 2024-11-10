// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:qrreader/feature/reports/data/model/all_reports_model.dart';
import 'package:qrreader/feature/reports/presentation/manger/reports_cubit.dart';

// import 'customer_model.dart';

class PdfReportService {
  ReportsCubit reportsCubit;

  PdfReportService({required this.reportsCubit});
  Future<void> printCustomersPdf() async {
    // Format the current date and time for the filename
    final String formattedDate =
        DateFormat('yyyy-MM-dd | HH:mm:ss').format(DateTime.now());
    // Create a new PDF document and add a page
    PdfDocument document = PdfDocument();
    PdfPage page = document.pages.add(); // Adding a page reference

    // Add a title to the document
    String titleText = "Be Healthy Report | $formattedDate";
    PdfTextElement title = PdfTextElement(
      text: titleText,
      font: PdfStandardFont(PdfFontFamily.helvetica, 18,
          style: PdfFontStyle.bold),
      brush: PdfBrushes.green, // Set title color to green
    );
    // Draw the title at the top of the page
    title.draw(
      page: page,
      bounds: const Rect.fromLTWH(0, 0, 500, 30),
    );

    // Add an image to the PDF (ensure you have a sample image)
    final imageData = await _loadImageData();
    if (imageData != null) {
      PdfBitmap image = PdfBitmap(imageData);
      // Draw the image below the title
      page.graphics.drawImage(image,
          const Rect.fromLTWH(0, 40, 100, 100)); // Adjust Y position if needed
    }

    // Define and populate the grid
    PdfGrid grid = PdfGrid();
    grid.columns.add(count: 5);
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = "Driver Name";
    header.cells[1].value = "Customer Name";
    header.cells[2].value = "B1 Status";
    header.cells[3].value = "B2 Status";
    header.cells[4].value = "Time";

    // Add header style
    header.style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightGray,
      textBrush: PdfBrushes.black,
      font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
    );

    // Add rows to the grid
    for (int i = 0; i < reportsCubit.tableData.length; i++) {
      String correctBag1State = reportsCubit.tableData[i].data.isEmpty
          ? "-"
          : reportsCubit.tableData[i].data[0].bagState == "stored_stage_2" ||
                  reportsCubit.tableData[i].data[0].bagState == "stored_stage_1"
              ? "At Store"
              : reportsCubit.tableData[i].data[0].bagState == "shipping"
                  ? "On Way"
                  : "Delivered";
      //-------------------------
      String correctBag2State = reportsCubit.tableData[i].data.isEmpty
          ? "-"
          : reportsCubit.tableData[i].data.length == 1
              ? "-"
              : reportsCubit.tableData[i].data[1].bagState ==
                          "stored_stage_2" ||
                      reportsCubit.tableData[i].data[1].bagState ==
                          "stored_stage_1"
                  ? "At Store"
                  : reportsCubit.tableData[i].data[1].bagState == "shipping"
                      ? "On Way"
                      : "Delivered";
      PdfGridRow row = grid.rows.add();
      //data[0] here is the bag1
      //data[1] here is the bag2
      row.cells[0].value = reportsCubit.tableData[i].data[0].driverName;
      row.cells[1].value = reportsCubit.tableData[i].customerName;
      //if the customer didnt have bags
      row.cells[2].value = correctBag1State;
      //if the customer didnt have bags and
      //if customer have 1 bag not 2
      row.cells[3].value = correctBag2State;
      row.cells[4].value = reportsCubit.tableData[i].data.isEmpty
          ? "-"
          : reportsCubit.tableData[i].data[0].date;
    }

    // Apply row style
    grid.style = PdfGridStyle(
      cellPadding: PdfPaddings(left: 10, right: 3, top: 4, bottom: 5),
      backgroundBrush: PdfBrushes.white,
      textBrush: PdfBrushes.black,
      font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
    );

    // Draw the grid below the image (adjust Y position based on title and image height)
    final gridStartY = imageData != null
        ? 160.0
        : 40.0; // Adjust based on whether an image was added
    grid.draw(page: page, bounds: Rect.fromLTWH(0, gridStartY, 0, 0));

    // Save the document
    List<int> bytes = await document.save();

    // Download document with date and time in the filename
    AnchorElement(
      href:
          "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}",
    )
      ..setAttribute("download", "report_$formattedDate.pdf")
      ..click();

    // Dispose the document
    document.dispose();
  }

  // Helper function to load image data
  Future<List<int>?> _loadImageData() async {
    // Load the image data from assets or network if needed
    // Example:
    // final ByteData data = await rootBundle.load('assets/image.png');
    // return data.buffer.asUint8List();
    return null; // Placeholder return
  }
}
