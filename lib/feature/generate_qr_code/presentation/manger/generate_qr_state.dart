part of 'generate_qr_cubit.dart';

@immutable
sealed class GenerateQrState {}

final class GenerateQrcubitInitial extends GenerateQrState {}

final class GenerateNewQrState extends GenerateQrState {}

final class ClearQrState extends GenerateQrState {}

final class GenerateQrLoadingState extends GenerateNewQrState {}

final class GenerateQrSuccessState extends GenerateNewQrState {
  final String message;

  GenerateQrSuccessState({required this.message});
}

final class GenerateQrFailureState extends GenerateNewQrState {
  final String error;

  GenerateQrFailureState({required this.error});

}

final class GetBagsLoadingState extends GenerateNewQrState{}
final class GetBagsSuccessState extends GenerateNewQrState{
  final String message;

  GetBagsSuccessState({required this.message});
}
final class GetBagsFailureState extends GenerateNewQrState{
    final String error;
    GetBagsFailureState({required this.error});
}

final class PrintContainerLoadingState extends GenerateNewQrState{}
final class PrintContainerSuccessState extends GenerateNewQrState{
  final String message;

  PrintContainerSuccessState({required this.message});
}

final class PrintContainerFailureState extends GenerateNewQrState{
    final String error;
    PrintContainerFailureState({required this.error});
}