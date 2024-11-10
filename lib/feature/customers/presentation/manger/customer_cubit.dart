import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrreader/constant.dart';
import 'package:qrreader/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:qrreader/feature/customers/data/model/all_customers_model.dart';
import 'package:qrreader/feature/customers/data/repos/customers_repo.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit(this.customersRepo) : super(CustomerInitial());
  CustomersRepo customersRepo;
  AllCustomersModel allCustomersModel =
      AllCustomersModel(code: 1, message: 'message', data: []);

  
  
  Future<void> getAllCustomers({required String role}) async {
    emit(GetCustomersLoading());
    var result = await customersRepo.getAllCustomers(role: role);
    result.fold((failure) {
      emit(GetCustomersFailure(error: failure.errMessage));
    }, (r) {
      allCustomersModel = AllCustomersModel.fromJson(r.data);
      if (role != 'inactive') dropdownList = [];
      if (role != 'inactive') customersMap = {};
      if (role != 'inactive') {
        for (int i = 0; i < allCustomersModel.data.length; i++) {
          if (allCustomersModel.data[i].state == 'inactive') continue;
          dropdownList.add(
              '${allCustomersModel.data[i].name}, Customer Id:${allCustomersModel.data[i].id}');
          customersMap.addAll(
              {allCustomersModel.data[i].name: allCustomersModel.data[i].id});
        }
      }
      emit(GetCustomersSuccess(message: allCustomersModel.message));
    });
  }

  Future<void> getCustomersByDriver({required int driverID}) async {
    emit(GetCustomerByDriverLoadingState());
    var result = await customersRepo.getCustomersByDriver(driverID: driverID);
    result.fold((failure) {
      if(failure.errMessage.contains('Internal Server error')){
        emit(GetCustomerByDriverFailureState(error: 'Failed to get customers'));
        return;
      }
      emit(GetCustomerByDriverFailureState(error: "Check your connection"));
    }, (r) {
      allCustomersModel = AllCustomersModel.fromJson(r.data);
      emit(GetCustomerByDriverSuccessState(message: allCustomersModel.message));
    });
  }

  Future<void> searchCustomers({required String search}) async {
    emit(SearchCustomersLoading());
    var result = await customersRepo.searchCustomers(search: search);
    result.fold((failure) {
      if(failure.errMessage.contains('Internal Server error')){
      emit(SearchCustomersFailure(error: 'Failed to get customers'));
      return;
      }
      else {
        emit(SearchCustomersFailure(error: 'Check your connection'));
      }
    }, (r) {
      allCustomersModel = AllCustomersModel.fromJson(r.data);

      emit(SearchCustomersSuccess(message: allCustomersModel.message));
    });
  }

  TextEditingController newNameController = TextEditingController();
  TextEditingController newPhoneNumberController = TextEditingController();
  TextEditingController newLocationController = TextEditingController();

  Future<void> addCustomers(context,
      {required String name,
      required String phoneNumber,
      required String location}) async {
    if (name.isEmpty || phoneNumber.isEmpty || location.isEmpty) {
      customSnackBar(context, "All Fields required", color: kUnsubsicriber);
      return;
    }
    String phoneNumber2 = newPhoneNumberController.text;
    if (newPhoneNumberController.text.startsWith('0')) {
      phoneNumber2 = newPhoneNumberController.text.substring(1);
    } else {
      emit(AddCustomersLoading());
      var result = await customersRepo.addNewCustomer(
          driverID: mapDrivers[newDriver]!,
          location: location,
          phoneNumber: phoneNumber2,
          fullName: name);
      result.fold((failure) {
        emit(AddCustomersFailure(error: failure.errMessage));
      }, (r) {
        emit(AddCustomersSuccess(message: allCustomersModel.message));
        getAllCustomers(role: 'all');
        newNameController.clear();
        newPhoneNumberController.clear();
        newLocationController.clear();
      });
    }
  }

  Future<void> editCustomers(context,
      {required num id,
      required String name,
      required String location,
      required String phoneNumber}) async {
    if (name.isEmpty || location.isEmpty || phoneNumber.isEmpty) {
      customSnackBar(context, "All Fields required", color: kUnsubsicriber);
    }
    if (phoneNumber.startsWith('0')) {
      phoneNumber = phoneNumber.substring(1);
    } else {
      emit(AddCustomersLoading());
      var result = await customersRepo.editCustomer(
          driverId: mapDrivers[newDriver]??0,
          phoneNumber: phoneNumber,
          location: location,
          name: name,
          id: id);
      result.fold((failure) {
        emit(GetCustomersFailure(error: failure.errMessage));
      }, (r) {
        emit(GetCustomersSuccess(message: r.data['message']));
        getAllCustomers(role: 'all');
      });
    }
  }

  Future<void> activeCustomer({required num id}) async {
    emit(AddCustomersLoading());
    var result = await customersRepo.activeCustomer(id: id);
    result.fold((failure) {
      emit(GetCustomersFailure(error: failure.errMessage));
    }, (r) {
      emit(GetCustomersSuccess(message: r.data['message']));
      getAllCustomers(role: 'all');
    });
  }


  Future<void> disAttachCustomer({required num customerId,required num bagId}) async {
    emit(DisAttachCustomerLoadingState());
    var result = await customersRepo.disAttachCustomer(bagId: bagId,customerId:customerId );
    result.fold((failure) {
      emit(DisAttachCustomerFailureState(error: failure.errMessage));
    }, (r) {
      emit(DisAttachCustomerSuccessState(message: r.data['message']));
      getAllCustomers(role: 'all');
    });
  }

  bool isExpand = false;

  void expandButton() {
    isExpand = !isExpand;
    emit(ExpandSelectState());
  }

  Future<void> inActiveCustomer({required num id}) async {
    emit(AddCustomersLoading());
    var result = await customersRepo.inActiveCustomerStatus(id: id);
    result.fold((failure) {
      emit(GetCustomersFailure(error: failure.errMessage));
    }, (r) {
      emit(GetCustomersSuccess(message: r.data['message']));
      getAllCustomers(role: 'all');
    });
  }

  Future<void> deleteCustomer({required num id}) async {
    emit(DeleteCustomerLoadingState());
    var result = await customersRepo.deleteCustomer(id: id);
    result.fold((failure) {
      emit(DeleteCustomerFailureState(error: failure.errMessage));
    }, (r) {
      emit(DeleteCustomerSuccessState(message: r.data['message']));
      getAllCustomers(role: 'all');
    });
  }

  String newDriver = 'All drivers';
}
