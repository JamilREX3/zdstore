import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zdstore/components/custom_snackbar.dart';
import 'package:zdstore/utils/api_request.dart';

class ResetPasswordController extends GetxController {
  late TextEditingController currentPasswordController;
  var currentPasswordValidator = false.obs;
  late TextEditingController newPasswordController;
  var newPasswordValidator = false.obs;
  late TextEditingController confirmPasswordController;
  var confirmPasswordValidator = false.obs;

  var loading = false.obs;
  var hasUppercase = false.obs;
  var hasLowercase = false.obs;
  var hasDigits = false.obs;
  var hasSymbol = false.obs;
  var hasSixCharacters = false.obs;
  var passwordsMatch = true.obs;

  realTimeValidation() {
    currentPasswordController.addListener(() {
      validate();
    });
    newPasswordController.addListener(() {
      //  hasUppercase
      hasUppercase.value =
          newPasswordController.text.contains(RegExp(r'[A-Z]'));
      //  hasLowercase
      hasLowercase.value =
          newPasswordController.text.contains(RegExp(r'[a-z]'));
      //  hasDigits
      hasDigits.value = newPasswordController.text.contains(RegExp(r'[0-9]'));
      //  hasSymbol
      hasSymbol.value = newPasswordController.text
          .contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
      //  hasSixCharacters
      hasSixCharacters.value = newPasswordController.text.length >= 6;
      if (confirmPasswordController.text.isNotEmpty) {
        passwordsMatch.value =
            newPasswordController.text == confirmPasswordController.text;
      }
      validate();
    });
    confirmPasswordController.addListener(() {
      passwordsMatch.value =
          newPasswordController.text == confirmPasswordController.text;
      validate();
    });
  }

  bool validate() {

    if (hasUppercase.value == true &&
        hasLowercase.value == true &&
        hasDigits.value == true &&
        hasSymbol.value == true &&
        hasSixCharacters.value == true &&
        newPasswordController.text.isNotEmpty == true) {
      newPasswordValidator.value = true;
    } else {
      newPasswordValidator.value = false;
    }
    if (passwordsMatch.value == true &&
        confirmPasswordController.text.isNotEmpty == true) {
      confirmPasswordValidator.value = true;
    } else {
      confirmPasswordValidator.value = false;
    }
    if (currentPasswordController.text.isNotEmpty == true) {
      currentPasswordValidator.value = true;
    } else {
      currentPasswordValidator.value = false;
    }
    if (currentPasswordValidator.value == true &&
        newPasswordValidator.value == true &&
        confirmPasswordValidator.value == true) {
      return true;
    } else {
      return false;
    }
  }

  changePassword() async{
    if (validate()) {
      loading.value = true;
      var response = await ApiRequest().post(
        path: '/profile/updatePassword',
        body: {
          'oldPassword': currentPasswordController.text,
          'newPassword': newPasswordController.text,
          'reNewPassword': confirmPasswordController.text,
        },
      );
      if(response.statusCode.toString().startsWith(RegExp(r'2'))){
        if(Get.isDialogOpen==true){
          Get.back();
        }
        CustomSnackbar.show(title: 'Successes',description: 'the password has been changed');
      }
      loading.value = false;
    }
  }
  @override
  void onInit() {
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    realTimeValidation();
    super.onInit();
  }
  @override
  void dispose() {
    newPasswordController.removeListener(() {});
    confirmPasswordController.removeListener(() {});
    currentPasswordController.removeListener((){});
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}