part of 'user_cubit.dart';

sealed class UserState {}

final class UserInitial extends UserState {}

final class AddPhotoSuccess extends UserState{}

final class CancelPhotoSuccess extends UserState{}

final class AddUserLoadingState extends UserState{}

final class AddUserFailureState extends UserState{
  final String error;
  AddUserFailureState({required this.error});
}

final class AddUserSuccessState extends UserState{
  final String message;
  AddUserSuccessState({required this.message});
}

final class GetUsersLoadingState extends UserState{}

final class GetUsersFailureState extends UserState{
  final String error;
  GetUsersFailureState({required this.error});
}

final class GetUsersSuccessState extends UserState{}
final class EmptyUsersState extends UserState{
  final String role;
  EmptyUsersState({required this.role});
}

final class DeleteUsersLoadingState extends UserState{}

final class DeleteUsersFailureState extends UserState{
  final String error;
  DeleteUsersFailureState({required this.error});
}

final class DeleteUsersSuccessState extends UserState{
  final String message;

  DeleteUsersSuccessState({required this.message});
}

final class EditUsersLoadingState extends UserState{}

final class EditUsersFailureState extends UserState{
  final String error;
  EditUsersFailureState({required this.error});
}

final class EditUsersSuccessState extends UserState{
  final String message;

  EditUsersSuccessState({required this.message});
}

final class ChangePasswordSecureState extends UserState{}
final class ExpandFiltersState extends UserState{}

final class UploadState extends UserState{}