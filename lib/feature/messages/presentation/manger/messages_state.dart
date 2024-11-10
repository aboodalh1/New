part of 'messages_cubit.dart';

sealed class MessagesState {}

final class MessagesInitial extends MessagesState {}

final class GetMessagesLoading extends MessagesState {}

final class GetMessagesSuccess extends MessagesState {
  final String message;

  GetMessagesSuccess({required this.message});
}

final class GetMessagesFailure extends MessagesState {
  final String error;

  GetMessagesFailure({required this.error});
}


final class GetUnverifiedLoading extends MessagesState {}

final class GetUnverifiedSuccess extends MessagesState {
  final String message;

  GetUnverifiedSuccess({required this.message});
}

final class GetUnverifiedFailure extends MessagesState {
  final String error;

  GetUnverifiedFailure({required this.error});
}

final class GetRegistersLoading extends MessagesState {}

final class GetRegistersSuccess extends MessagesState {
  final String message;

  GetRegistersSuccess({required this.message});
}

final class GetRegistersFailure extends MessagesState {
  final String error;

  GetRegistersFailure({required this.error});
}

final class AcceptUserLoading extends MessagesState {}

final class AcceptUserSuccess extends MessagesState {
  final String message;

  AcceptUserSuccess({required this.message});
}

final class AcceptUserFailure extends MessagesState {
  final String error;

  AcceptUserFailure({required this.error});
}

final class RejectUserLoading extends MessagesState {}

final class RejectUserSuccess extends MessagesState {
  final String message;

  RejectUserSuccess({required this.message});
}

final class RejectUserFailure extends MessagesState {
  final String error;

  RejectUserFailure({required this.error});
}
