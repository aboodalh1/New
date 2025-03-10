import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrreader/core/util/api_service.dart';

import 'package:qrreader/feature/users/data/model/all_users_model.dart';
import 'package:qrreader/feature/users/data/model/user_model.dart';

import '../../../../constant.dart';
import '../../data/repos/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepo) : super(UserInitial());
  UserRepo userRepo;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String selectedJob = "driver";

  void changeDropDownValue({required String value}) {
    selectedJob = value;
  }
  int currentUser = 0;


  void getCurrentUser ()async{
    currentUser = await DioHelper.getId()??0;
  }
  bool isSecure = true;
  bool confirmIsSecure = true;
  IconData passwordIcon = Icons.remove_red_eye;
  IconData confirmPasswordIcon = Icons.remove_red_eye;

  void changePasswordSecure() {
    isSecure = !isSecure;
    passwordIcon =
        isSecure ? Icons.remove_red_eye : Icons.remove_red_eye_outlined;
    emit(ChangePasswordSecureState());
  }

  void changeConfirmPasswordSecure() {
    confirmIsSecure = !confirmIsSecure;
    confirmPasswordIcon =
        confirmIsSecure ? Icons.remove_red_eye : Icons.remove_red_eye_outlined;
    emit(ChangePasswordSecureState());
  }


  void cancelPhoto() {
    bytesData = null;
    emit(CancelPhotoSuccess());
  }

  AllUsersModel allUsersModel =
      AllUsersModel(code: 1, message: 'message', data: []);
  UserModel? userModel = UserModel(
      code: 1,
      message: 'message',
      data: UserData(
          image:'',
          verified:true,
          id: 1,
          name: 'name',
          phone: 'phone',
          employeeNumber: 'employeeNumber',
          role: 'role'));

  Future<void> addUser() async {
    String phoneNumber = phoneNumberController.text;
    if(fullNameController.text==''||phoneNumberController.text==''||passwordController.text==''||confirmPasswordController.text==''){
      emit(AddUserFailureState(error: 'All field required'));
    }
    if (phoneNumberController.text.startsWith('0')) {
      phoneNumber=phoneNumberController.text.substring(1);

    }
    emit(AddUserLoadingState());
    var response =
    await userRepo.addNewUser(
      image: _selectedFile??[],
        name: fullNameController.text,
        phone: phoneNumber,
        role: selectedJob.toLowerCase(),
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text)
        ;
    response.fold((failure) {
      emit(AddUserFailureState(error: failure.errMessage));
    }, (response) {
      userModel = UserModel.fromJson(response.data);
      fullNameController.clear();
      phoneNumberController.clear();
      selectedJob = '';
      passwordController.clear();
      confirmPasswordController.clear();
      getAllUser(role: 'all');
      emit(AddUserSuccessState(message: userModel!.message));
    });
  }

  num editID = 0;
  Future<void> editUser() async {
    emit(EditUsersLoadingState());
    var response = await userRepo.editUser(
      image: _selectedFile??[],
      name: fullNameController.text,
      phone: phoneNumberController.text,
      role: selectedJob.toLowerCase(),
      id: editID,
    );
    response.fold((failure) {
      emit(EditUsersFailureState(error: failure.errMessage));
    }, (response) {
      getAllUser(role: 'all');
      fullNameController.clear();
      phoneNumberController.clear();
      selectedJob = '';
      imageController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      emit(EditUsersSuccessState(message: "User info updated successfully"));
    });
  }

  bool isFiltered = false;

  Future<void> getAllUser({required String role}) async {
     if(role=='all'){ drivers = [];
      mapDrivers = {};}
    emit(GetUsersLoadingState());
    rows = [];
    role != 'all' ? isFiltered = true : isFiltered = false;
    var result = await userRepo.getAllUsers(role: role);
    result.fold((failure) {
      emit(GetUsersFailureState(error: failure.errMessage));
    }, (response) {
      isExpanded = false;
      allUsersModel = AllUsersModel.fromJson(response.data);
      allUsersModel.data.removeWhere((element) => element.id==1);
      if (allUsersModel.data.isEmpty) {
        emit(EmptyUsersState(role: role));
      } else {
        if(role=='all'){
          List<String>uniqueDrivers = [];
        uniqueDrivers.add('all');
        for(int i=0;i<allUsersModel.data.length;i++){
           if(allUsersModel.data[i].role!='driver')continue;
          uniqueDrivers.add(allUsersModel.data[i].name);
          mapDrivers.addAll({allUsersModel.data[i].name:allUsersModel.data[i].id});
        }
        drivers = uniqueDrivers.toSet().toList();
        }

        emit(GetUsersSuccessState());
      }
    });
  }

  List<DataRow> rows = [];

  Future<void> deleteUser({required num id}) async {
    emit(DeleteUsersLoadingState());
    var result = await userRepo.deleteUser(id: id);
    result.fold((failure) {
      emit(DeleteUsersFailureState(error: failure.errMessage));
    }, (r) {
      getAllUser(role: 'all');
        emit(DeleteUsersSuccessState(message: r.data['message']));
    });
  }

  bool isExpanded = false;

  void expandFilterButton() {
    isExpanded = !isExpanded;
    emit(ExpandFiltersState());
  }


  List<int>? _selectedFile =[];
  Uint8List? bytesData;

  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files == null || files.isEmpty) {
        return;
      }

      final file = files[0];

      if (file.type != "image/png" && file.type != "image/jpeg" && file.type != "image/jpg") {
        emit(UploadErrorState(error: "The picture must be .png, .jpg, .jpeg"));
        return;
      }
      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) {
          bytesData =
              const Base64Decoder().convert(reader.result.toString().split(",").last);
          _selectedFile = bytesData;
        emit(UploadState());
      });
      reader.readAsDataUrl(file);
    });
  }

}
