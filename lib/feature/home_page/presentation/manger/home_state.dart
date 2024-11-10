part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ChangePage extends HomeState{}

final class InitialPage extends HomeState{}

final class GetReadsLoadingState extends HomeState{}
final class GetReadsFailureState extends HomeState{
  final String error;
  GetReadsFailureState({required this.error});
}
final class GetReadsSuccessState extends HomeState{
  final String message;
  GetReadsSuccessState({required this.message});
}
final class EmptyReadsState extends HomeState{
  final String message;
  EmptyReadsState({required this.message});
}
final class SignOutLoadingState extends HomeState {}

final class SignOutSuccessState extends HomeState {
  final String message;
  SignOutSuccessState({required this.message});

}

final class SignOutFailureState extends HomeState {
  final String error;

  SignOutFailureState({required this.error});

}