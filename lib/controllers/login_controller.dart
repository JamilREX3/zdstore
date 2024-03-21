import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zdstore/models/login_user_model.dart';
import 'package:zdstore/utils/api_request.dart';
import 'package:zdstore/views/auth_view.dart';

import '../components/custom_snackbar.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var obscureText = true.obs;
  final dio = Dio();

  bool _validateFields() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      CustomSnackbar.show(
          title: 'Error', description: 'Please fill in all fields');
      return false;
    }
    if (passwordController.text.length < 6) {
      CustomSnackbar.show(
          title: 'Error',
          description: 'Password must be at least 6 characters');
      return false;
    }
    return true;
  }

  void login() async {
    if (_validateFields()) {
      bool isEmail= false;
      if(emailController.text.contains('@')){
        isEmail=true;
      }
      var response = await ApiRequest().post(
        path: '/login',
        authRequire: false,
        body: isEmail==false?{
          'username': emailController.text,
          'password': passwordController.text,
        }:{
          'email': emailController.text,
          'password': passwordController.text,
        },
      );
      if(response.statusCode ==200){
        LoginUserModel loginUserModel = LoginUserModelReq.fromJson(response.data).loginUserModel!;
        await GetStorage().write('token', loginUserModel.token);
        Get.offAll(const AuthView());
      }
    }
  }
}

