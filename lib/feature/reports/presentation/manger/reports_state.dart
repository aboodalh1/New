part of 'reports_cubit.dart';

sealed class ReportsState {}

final class ReportsInitial extends ReportsState {}

final class GetReportsLoadingState extends ReportsState {}
//===================Zak=================
// Define a new state for future date errors
class FutureDateErrorState extends ReportsState {
  final String message;
  FutureDateErrorState(this.message);
}
//===================Zak=================
final class GetReportsSuccessState extends ReportsState {
  final String message;
  GetReportsSuccessState({required this.message});
}
final class GetReportsFailureState extends ReportsState{
  final String error;
  GetReportsFailureState({required this.error});
}