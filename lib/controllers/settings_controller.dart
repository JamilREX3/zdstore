import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zdstore/models/user_model.dart';
import 'package:zdstore/utils/api_request.dart';
import 'package:zdstore/utils/enum_state.dart';

enum WhichOtp {
  googleAuth,
  permanentAuth,
}

class SettingsController extends GetxController {
  Rx<CurrentState> currentState = CurrentState.loading.obs;
  late UserModel userModel;
  var googleAuth = false.obs;

  var needOtpAuthWidget = false.obs;
  var needOtpPermanentWidget = false.obs;
  var permanentVerification = false.obs;

  getMe() async {
    currentState.value = CurrentState.loading;
    var response = await ApiRequest().get(path: '/me');
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      userModel = UserModelReq.fromJson(response.data).userModel!;
    }
    print('lllllllllll');
    currentState.value = CurrentState.full;
  }

  conf() {
    if (userModel.provider2fa == null || userModel.provider2fa == false) {
      googleAuth.value = false;
    } else{
      googleAuth.value = true;
      if(userModel.otpEnable==1){
        permanentVerification.value = true;
      }else{
        permanentVerification.value=false;
      }
    }
  }

  changeLanguage(String lCode) async {
    await GetStorage().write('language', lCode);
    Get.updateLocale(Locale(lCode));
    // var currentLang = Get.locale!.languageCode;
    // if(currentLang=='en'){
    //   await GetStorage().write('language', 'ar');
    //   Get.updateLocale(const Locale('ar'));
    // }else{
    //   await GetStorage().write('language', 'en');
    //   Get.updateLocale(const Locale('en'));
    // }
  }

  sendCodeToEmail(bool value, WhichOtp whichOtp) async {
    currentState.value = CurrentState.loading;
    var response = await ApiRequest().post(path: '/secretKey');
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      if (whichOtp == WhichOtp.googleAuth) {
        needOtpAuthWidget.value = true;
      } else if (whichOtp == WhichOtp.permanentAuth) {
        needOtpPermanentWidget.value = true;
      }
    } else {
      if (whichOtp == WhichOtp.googleAuth) {
        needOtpAuthWidget.value = false;
      } else if (whichOtp == WhichOtp.permanentAuth) {
        needOtpPermanentWidget.value = false;
      }
    }
    currentState.value = CurrentState.full;
  }

  changeGoogleAuth(bool newValue) {
    googleAuth.value = newValue;
    if (newValue == true && userModel.provider2fa != 'google') {
      sendCodeToEmail(newValue, WhichOtp.googleAuth);
    } else if (newValue == false && userModel.provider2fa == 'google') {
      sendCodeToEmail(newValue, WhichOtp.googleAuth);
    }
  }

  changePermanentVerification(bool newValue) {
    permanentVerification.value = newValue;
    if (newValue == true && userModel.otpEnable == 0) {
      sendCodeToEmail(newValue, WhichOtp.permanentAuth);
    } else if (newValue == false && userModel.otpEnable == 1) {
      sendCodeToEmail(newValue, WhichOtp.permanentAuth);
    }
  }

  submitCodeToUpdateProfile(
      {required String verificationCode}) async {
    currentState.value = CurrentState.loading;
    var response = await ApiRequest().post(path: '/profile/update', body: {
      'provider_2fa': googleAuth.value == true ? 'google' : null,
      'otpCode': verificationCode,
      'otp_enable':permanentVerification.value==true?1:0,
    });
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      needOtpAuthWidget.value = false;
      needOtpPermanentWidget.value = false;
      init();
    } else {
      currentState.value = CurrentState.full;
    }
  }

  init() async {
    await getMe();
    conf();
    update();
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
