part of 'customer_cubit.dart';

sealed class CustomerState {}

final class CustomerInitial extends CustomerState {}


final class ExpandSelectState extends CustomerState {}

final class GetCustomersLoading extends CustomerState {}

final class GetCustomersSuccess extends CustomerState {
  final String message;

  GetCustomersSuccess({required this.message});
}

final class GetCustomersFailure extends CustomerState {
  final String error;

  GetCustomersFailure({required this.error});
}

final class SearchCustomersLoading extends CustomerState {}

final class SearchCustomersSuccess extends CustomerState {
  final String message;

  SearchCustomersSuccess({required this.message});
}

final class SearchCustomersFailure extends CustomerState {
  final String error;

  SearchCustomersFailure({required this.error});
}

final class GetCustomerByDriverLoadingState extends CustomerState{}
final class GetCustomerByDriverSuccessState extends CustomerState{
  final String message;

  GetCustomerByDriverSuccessState({required this.message});

}
final class GetCustomerByDriverFailureState extends CustomerState{
  final String error;

  GetCustomerByDriverFailureState({required this.error});
}


final class AddCustomersLoading extends CustomerState {}

final class AddCustomersSuccess extends CustomerState {
  final String message;

  AddCustomersSuccess({required this.message});
}

final class AddCustomersFailure extends CustomerState {
  final String error;

  AddCustomersFailure({required this.error});
}

final class EditCustomerLoading extends CustomerState {}

final class EditCustomerSuccess extends CustomerState {
  final String message;

  EditCustomerSuccess({required this.message});
}

final class EditCustomerFailure extends CustomerState {
  final String error;

  EditCustomerFailure({required this.error});
}

final class DeleteCustomerLoadingState extends CustomerState {}

final class DeleteCustomerSuccessState extends CustomerState {
  final String message;

  DeleteCustomerSuccessState({required this.message});
}

final class DeleteCustomerFailureState extends CustomerState {
  final String error;

  DeleteCustomerFailureState({required this.error});
}

final class DisAttachCustomerLoadingState extends CustomerState {}

final class DisAttachCustomerSuccessState extends CustomerState {
  final String message;

  DisAttachCustomerSuccessState({required this.message});
}

final class DisAttachCustomerFailureState extends CustomerState {
  final String error;

  DisAttachCustomerFailureState({required this.error});
}
