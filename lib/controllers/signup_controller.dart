

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zdstore/models/login_user_model.dart';
import '../components/custom_snackbar.dart';
import '../utils/api_request.dart';
import '../views/auth_view.dart';
class SignUpController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  void signUp() async {
    if (_validateFields()) {
      var response = await ApiRequest().post(
          path: '/create',
          authRequire: false,
          body: {
            'first_name' : firstNameController.text,
            'last_name' : lastNameController.text,
            'username' : userNameController.text,
            'email': emailController.text,
            'password': passwordController.text,
          });
      if (response.statusCode! >= 200) {
        LoginUserModel loginUserModel = LoginUserModelReq.fromJson(response.data).loginUserModel!;
        await GetStorage().write('token', loginUserModel.token);
        Get.offAll(const AuthView());
      }
    }
  }

  bool _validateFields() {
    if (firstNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        userNameController.text.isEmpty ||
        lastNameController.text.isEmpty) {
      CustomSnackbar.show(title: 'Error', description: 'Please fill in all fields');
      return false;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      CustomSnackbar.show(title:'Error', description: 'Please enter a valid email');
      return false;
    }
    if (passwordController.text.length < 6) {
      CustomSnackbar.show(title:'Error', description: 'Password must be at least 6 characters');
      return false;
    }
    return true;
  }
}