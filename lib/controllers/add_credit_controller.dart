import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:zdstore/controllers/global_controller.dart';
import 'package:zdstore/models/bank_model.dart';
import 'package:zdstore/utils/api_request.dart';
import '../components/custom_snackbar.dart';
import '../models/currency_model.dart';

class AddCreditController extends GetxController {
  final BankModel bankModel;
  final List<CurrencyModel> currenciesList;

  AddCreditController({required this.bankModel, required this.currenciesList});

  RoundedLoadingButtonController roundedLoadingButtonController =
      RoundedLoadingButtonController();
  List<String> infoList = [];
  List<FullRequiresForm> fullRequiresForms = [];
  Rx<CurrencyModel>? selectedCurrencyModel;
  TextEditingController creditValue = TextEditingController();
  TextEditingController valueAfterTax = TextEditingController();

  String amountErrorText = '';

  calcTax() {
    if (creditValue.text.isEmpty) {
      valueAfterTax.text = '';
    } else {
      double localCurrencyPrice = double.parse(Get.find<GlobalController>()
          .userModel
          .value
          .currencyPrice
          .toString()); //14300
      double selectedCurrencyPrice = selectedCurrencyModel != null
          ? double.parse(selectedCurrencyModel!.value.price.toString())
          : localCurrencyPrice;
      valueAfterTax.text = ((localCurrencyPrice / selectedCurrencyPrice) *
              double.parse(creditValue.text) *
              (100.0 -
                  double.parse(bankModel.tax != null ? bankModel.tax! : '0')) /
              100)
          .toString();
    }
  }

  final ImagePicker picker = ImagePicker();
  XFile? pickedImage;

  pickImage() async {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  confInfo() {
    infoList = bankModel.info.toString().split('\n');
  }

  confTextFormField() {
    if (bankModel.bankRequire != null && bankModel.bankRequire!.isNotEmpty) {
      for (var x in bankModel.bankRequire!) {
        fullRequiresForms.add(FullRequiresForm(
            bankRequire: x, textEditingController: TextEditingController()));
      }
    }
  }

  Future<String> uploadImage() async {
    var response = await ApiRequest().post(path: '/tool/uploadImage', body: {
      'type': 'transfer',
      'image': File(pickedImage!.path),
    });
    print('rrrrr${response.statusCode}rrrrr = ${response.data}');
    return response.data['data'].toString();
  }

  _validate() {
    for (var r in fullRequiresForms) {
      if (r.textEditingController.text.isEmpty) {
        CustomSnackbar.show(
            title: 'Error', description: 'Please fill in all fields');
        return false;
      }
    }
    if (creditValue.text.isEmpty) {
      CustomSnackbar.show(
          title: 'Error', description: 'Please fill in all fields');
      return false;
    }
    return true;
  }

  Future<void>submit() async {
    Map<String, dynamic> requiresMap = {};
    if (_validate()) {
      var currentRoute = Get.currentRoute;
      roundedLoadingButtonController.start();
      if (pickedImage != null) {
        String? imageUrl = await uploadImage();
        if (imageUrl.isNotEmpty) {
          requiresMap['image'] = imageUrl;
        }
      }
      if (fullRequiresForms.isNotEmpty) {
        requiresMap['detail'] = {};
      }
      for (var r in fullRequiresForms) {
        requiresMap['detail'][r.bankRequire.fieldName.toString()] =
            r.textEditingController.text;
      }
      requiresMap['amount'] = creditValue.text;
      if (selectedCurrencyModel?.value != null) {
        requiresMap['currency_id'] = selectedCurrencyModel!.value.id;
      } else {
        requiresMap['currency_id'] =
            Get.find<GlobalController>().userModel.value.currencyId.toString();
      }
      requiresMap['bank_id'] = bankModel.id.toString();
      var response = await ApiRequest().post(
        path: '/transfer/addOrder',
        body: requiresMap,
      );
      if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
        if (currentRoute == Get.currentRoute) {
          Get.back(closeOverlays: true);
        }
        CustomSnackbar.show(
            title: 'Successes', description: 'Your order has been sent');
      }
      roundedLoadingButtonController.stop();
    }
  }

  init() {
    confInfo();
    confTextFormField();
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}

class FullRequiresForm {
  final BankRequire bankRequire;
  final TextEditingController textEditingController;

  FullRequiresForm(
      {required this.bankRequire, required this.textEditingController});
}
