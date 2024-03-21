import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import 'package:zdstore/components/custom_text.dart';
import 'package:zdstore/models/user_model.dart';
import 'package:zdstore/utils/api_request.dart';
import 'package:zdstore/views/global_view.dart';
import 'package:zdstore/views/login_view.dart';
import 'package:zdstore/views/set_info_view.dart';

class AuthController extends GetxController {
  auth() async {
    var token = await GetStorage().read('token');
    if (token == null) {
      print('token = $token');
      Get.offAll(LoginView());
    } else {
      dio.Response? response = await ApiRequest().get(path: '/me');
      print('response code of \'/me\' : ${response.statusCode}');
      print('response body of \'/me\' : ${response.data}');
      if (response.statusCode == 200) {
        UserModel userModel = UserModelReq.fromJson(response.data).userModel!;
        if (userModel.active == 0) {
          // the user is banded
          //todo get off all to banded screen
          Get.offAll(const Scaffold(
            body: Center(
              child: CustomText('Banned'),
            ),
          ));
          //print('the user is banned');
        } else if (userModel.phone == null || userModel.currencyId == null) {
          //todo get to set phone and currency page
          Get.to(const SetInfoView());
        } else {
          Get.offAll(GlobalView(userModel: userModel));
        }
      } else if(response.statusCode!=1000){
        print('kkkkkkkkkkkkkkkk    ${response.statusCode}');
        Get.offAll(LoginView());
      }else{
        //todo show try again
      }
    }
  }
}
