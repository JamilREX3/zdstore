import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:zdstore/models/user_model.dart';

import '../components/custom_snackbar.dart';
import '../utils/api_request.dart';
import '../utils/enum_state.dart';

class ProfileController extends GetxController {
  Rx<CurrentState> currentState = CurrentState.loading.obs;
  UserModel userModel = UserModel();

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  RoundedLoadingButtonController roundedLoadingButtonController =
  RoundedLoadingButtonController();

  getUserInfo() async {
    currentState.value = CurrentState.loading;
    var response = await ApiRequest().get(path: '/me');
    if (response.statusCode == 200) {
      userModel = UserModelReq
          .fromJson(response.data)
          .userModel!;
      currentState.value = CurrentState.full;
    } else {
      currentState.value = CurrentState.error;
    }
  }

  setTextControllers() {
    firstNameController = TextEditingController(text: userModel.firstName);
    lastNameController = TextEditingController(text: userModel.lastName);
  }


  final ImagePicker picker = ImagePicker();
  XFile? pickedImage;

  pickImage() async {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  Future<String> uploadImage() async {
    var response = await ApiRequest().post(path: '/tool/uploadImage', body: {
      'type': 'avatar',
      'image': File(pickedImage!.path),
    });
    print('rrrrr${response.statusCode}rrrrr = ${response.data}');
    return response.data['data'].toString();
  }


  _validate() {
    if (firstNameController.text.isEmpty || lastNameController.text.isEmpty) {
      CustomSnackbar.show(
          title: 'Error', description: 'Please fill in all fields');
      return false;
    }
    return true;
  }


  Future<void> submit() async {
    Map<String, dynamic> bodyMap = {};
    if (_validate()) {
      roundedLoadingButtonController.start();
      bodyMap['id'] = userModel.id.toString();
      if (pickedImage != null) {
        String? imageUrl = await uploadImage();
        if (imageUrl.isNotEmpty) {
          bodyMap['avatar'] = imageUrl;
        }
      }
      bodyMap['first_name'] = firstNameController.text;
      bodyMap['last_name'] = lastNameController.text;

      var response = await ApiRequest().post(
        path: '/profile/update',
        body: bodyMap,
      );
      if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
        CustomSnackbar.show(
            title: 'Successes', description: 'Your order has been sent');
        init();
      }
      roundedLoadingButtonController.stop();

    }
  }


    init() async {
      await getUserInfo();
      setTextControllers();
    }

    @override
    void onInit() {
      init();
      super.onInit();
    }
  }