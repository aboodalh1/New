import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrreader/feature/generate_qr_code/data/model/generate_qr_model.dart';

part 'qrs_list_to_download_state.dart';

class QrsListToDownloadCubit extends Cubit<QrsListToDownloadState> {
  QrsListToDownloadCubit() : super(QrsListToDownloadState(qrList: []));

  void addQrData(GenerateQrDataModel qrData) {
    emit(state.copyWith(qrList: [...state.qrList, qrData]));
  }

  void clearQrData() {
    state.qrList.clear();
    emit(state.copyWith(qrList: []));
  }
}
