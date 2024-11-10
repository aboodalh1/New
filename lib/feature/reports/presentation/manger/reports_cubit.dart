import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qrreader/feature/reports/data/model/all_reports_model.dart';

import '../../data/repos/reports_repo.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit(this.reportsRepo) : super(ReportsInitial());
  ReportsRepo reportsRepo;
  DateTime? selectedDate;
  List<TableModel> tableData = [];
  TextEditingController dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      //====================Zak========================
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff0F663C), // Selected date color
              onPrimary: Colors.white, // Text color on selected date
              surface: Colors.white, // Dialog background color
            ),
            dialogBackgroundColor:
                Colors.white, // Overall dialog background color
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xff0F663C), // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      //====================Zak========================
    );
    // Check if the selected date is in the future
    if (picked != null && picked.isAfter(DateTime.now())) {
      emit(FutureDateErrorState("You can't view reports for a future date."));
    } else if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      getAllReports();
    }
    // if (picked != null && picked != selectedDate) {
    //   selectedDate = picked;
    //   dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    //   getAllReports();
    // }
  }
  AllReportsModel allReportsModel = AllReportsModel(
      data: Data(
          cards: Cards(
              storedStage_1: 1, storedStage_2: 1, shipping: 1, delivered: 1),
          table: []),
      message: '',
      code: 1);
  Future<void> getAllReports() async {
    desktopRows = [];
    emit(GetReportsLoadingState());
    var result = await reportsRepo.getReports(date: dateController.text);
    result.fold((failure) {
      emit(GetReportsFailureState(error: failure.errMessage));
    }, (response) {
      allReportsModel = AllReportsModel.fromJson(response.data);
      emit(GetReportsSuccessState(message: allReportsModel.message));
    });
  }

  List<DataRow> desktopRows = [];
  List<DataRow> tabletRows = [];
  List<DataRow> mobileRow = [];
}
