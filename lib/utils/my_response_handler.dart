import 'package:dio/dio.dart'as dio;
import 'package:get/get.dart';

import '../views/need_otp_auth_view.dart';

class MyResponseHandler {


  static void handle(dio.Response response){
    if(response.statusCode==402){
      print('***************402*********************');
      Get.offAll(const NeedOtpAuth());
    }
  }









}