part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class SignInLoadingState extends AuthState {}

final class SignInSuccessState extends AuthState {}

final class SignInFailureState extends AuthState {
  final String error;

  SignInFailureState({required this.error});

}

final class GetMyInfoLoadingState extends AuthState {}

final class GetMyInfoSuccessState extends AuthState {
  final String message;
  GetMyInfoSuccessState({required this.message});

}

final class GetMyInfoFailureState extends AuthState {
  final String error;

  GetMyInfoFailureState({required this.error});

}

final class ChangePasswordSecureState extends AuthState {}
