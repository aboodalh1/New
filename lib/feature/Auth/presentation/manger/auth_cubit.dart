import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:qrreader/constant.dart';
import 'package:qrreader/core/util/function/navigation.dart';
import 'package:qrreader/core/widgets/custom_snack_bar/custom_snack_bar.dart';
import 'package:qrreader/dashboard.dart';
import 'package:qrreader/feature/Auth/data/model/login_user_model.dart';
import 'package:qrreader/feature/Auth/data/repos/auth_repo.dart';
import 'package:qrreader/feature/users/data/model/user_model.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  AuthRepo authRepo;
  LoginUserModel userModel= LoginUserModel(code: 1, message: 'message', data: Data(token: 'token', role: 'role')) ;
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  Future<void> login(context) async {
      String phoneNumber = phoneNumberController.text;
    if (phoneNumberController.text == '' || passwordController.text == '') {
      customSnackBar(context, 'All field Required', color: kOnWayColor);
    }
    else {
    if (phoneNumberController.text.startsWith('0')) {
    phoneNumber= phoneNumberController.text.substring(1);
      // phoneNumberController.text=phoneNumberController.text.substring(1);
    }
      emit(SignInLoadingState());
      var result = await authRepo.login(
          phone: phoneNumber.trim(),
          password: passwordController.text.trim());
      result.fold(
          (failure) => {emit(SignInFailureState(error: failure.errMessage))},
          (response) async{
        userModel = LoginUserModel.fromJson(response.data);
        if(userModel.data.role!='admin'){
          customSnackBar(context, 'Unauthorized',color: kOnWayColor);
        }
        else {
          emit(SignInSuccessState());
          customSnackBar(context, userModel.message);
          navigateAndFinish(context, const DashboardPage(startRoute: 'home',));
        }});
    }
  }
 UserModel myInfo= UserModel(code: 1, message: 'message', data: UserData(id: 1, name: 'name', phone: 'phone', employeeNumber: 'employeeNumber', role: 'role', image: '', verified: true));

  bool isSecure = true;
  IconData passwordIcon = Icons.remove_red_eye_outlined;
  void changeSecure() {
    isSecure = !isSecure;
    passwordIcon =
        isSecure ? Icons.remove_red_eye : Icons.remove_red_eye_outlined;
    emit(ChangePasswordSecureState());
  }
}
