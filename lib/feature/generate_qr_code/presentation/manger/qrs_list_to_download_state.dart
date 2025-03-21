part of 'qrs_list_to_download_cubit.dart';

class QrsListToDownloadState {
  final List<GenerateQrDataModel> qrList;

  QrsListToDownloadState({required this.qrList});

  // CopyWith method
  QrsListToDownloadState copyWith({List<GenerateQrDataModel>? qrList}) {
    return QrsListToDownloadState(
      qrList: qrList ?? this.qrList,
    );
  }
}
