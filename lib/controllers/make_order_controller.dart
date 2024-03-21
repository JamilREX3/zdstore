import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:uuid/uuid.dart';
import 'package:zdstore/controllers/global_controller.dart';
import 'package:zdstore/models/home_content_model.dart';
import 'package:zdstore/utils/api_request.dart';

import '../components/custom_snackbar.dart';
import '../utils/enum_state.dart';
import 'package:dio/dio.dart'as dio;

class MakeOrderController extends GetxController {
  Rx<CurrentState> currentState = CurrentState.loading.obs;

  final String? productId;
  ProductModel? product;
  var loading = false.obs;
  RoundedLoadingButtonController roundedLoadingButtonController = RoundedLoadingButtonController();

  MakeOrderController({this.product, this.productId});

  List<Requires> textFieldRequires = []; //textFields section
  List<TextEditingController> requiresTextEditingControllersList = [];

  List<Requires> dropDownRequires = []; //DropDowns section
  List<String> dropDownSelectedValues = [];

  List<Requires> amountsRequires = []; // amount section
  List<TextEditingController> amountsTextEditingControllers = [];

  List<Requires> quantityRequires = []; //incDec section
  List<TextEditingController> quantityTextEditingControllers = [];

  TextEditingController? totalPrice;
  bool otpEnabled = false;
  TextEditingController? otpTextController;

  final RxString amountErrorText = ''.obs;

  calcTotalPrice(String amount, num min, num max) {
    double? amountAsDouble = double.tryParse(amount);
    if (amountAsDouble != null &&
        amountAsDouble >= min &&
        amountAsDouble <= max) {
      amountErrorText.value = '';
      totalPrice!.text =
          (product!.basePrice! * amountAsDouble).toStringAsFixed(3);
    } else if (amountAsDouble != null) {
      totalPrice!.text = 'Error'.tr;
      if (amountAsDouble <= min) {
        amountErrorText.value = '${'amount must be more than'.tr} $min';
      } else {
        amountErrorText.value = '${'amount must be less than'.tr} $max';
      }
    } else {
      totalPrice!.text = 'Error'.tr;
    }
  }

  bool _validate() {
    if (requiresTextEditingControllersList.isNotEmpty) {
      for (TextEditingController t in requiresTextEditingControllersList) {
        if (t.text.isEmpty) {
          CustomSnackbar.show(
              title: 'Error', description: 'Please fill in all fields');
          return false;
        }
      }
    }
    if (dropDownSelectedValues.isNotEmpty) {
      for (String t in dropDownSelectedValues) {
        if (t.isEmpty) {
          CustomSnackbar.show(
              title: 'Error', description: 'Please fill in all fields');
          return false;
        }
      }
    }
    if (amountsTextEditingControllers.isNotEmpty) {
      for (TextEditingController t in amountsTextEditingControllers) {
        if (t.text.isEmpty) {
          CustomSnackbar.show(
              title: 'Error', description: 'Please fill in all fields');
          return false;
        }
      }
    }

    if (quantityTextEditingControllers.isNotEmpty) {
      for (TextEditingController t in quantityTextEditingControllers) {
        if (t.text.isEmpty) {
          CustomSnackbar.show(
              title: 'Error', description: 'Please fill in all fields');
          return false;
        }
      }
    }

    if (otpEnabled == true) {
      if (otpTextController!.text.isEmpty) {
        CustomSnackbar.show(
            title: 'Error', description: 'Please fill in all fields');
        return false;
      }
    }

    return true;
  }

  implementRequires() {
    textFieldRequires = [];
    dropDownRequires = [];
    amountsRequires = [];
    if (product!.requires != null) {
      for (Requires req in product!.requires!) {
        if (req.type != null && req.type == 'text') {
          textFieldRequires.add(req);
          TextEditingController textEditingController = TextEditingController();
          requiresTextEditingControllersList.add(textEditingController);
        } else if (req.type != null && req.type == 'selectQty') {
          dropDownRequires.add(req);
          dropDownSelectedValues.add('');
        } else if (req.type != null && req.type == 'amount') {
          totalPrice ??= TextEditingController();
          calcTotalPrice(
              req.typeValue['min'].toString(),
              num.parse(req.typeValue['min'].toString()),
              num.parse(req.typeValue['max'].toString()));
          amountsRequires.add(req);
          TextEditingController textEditingController =
              TextEditingController(text: req.typeValue['min'].toString());
          print('req.typeValue[0]:${req.typeValue['max'].toString()}');
          amountsTextEditingControllers.add(textEditingController);
        } else if (req.type != null && req.type == 'quantity') {
          totalPrice ??= TextEditingController();
          calcTotalPrice(
              req.typeValue['min'].toString(),
              num.parse(req.typeValue['min'].toString()),
              num.parse(req.typeValue['max'].toString()));
          quantityRequires.add(req);
          TextEditingController textEditingController =
              TextEditingController(text: req.typeValue['min'].toString());
          print('req.typeValue[0]:${req.typeValue['max'].toString()}');
          quantityTextEditingControllers.add(textEditingController);
        }
      }
    }
    if (otpEnabled == true) {
      otpTextController = TextEditingController();
    }
    update();
  }

  Map<String, dynamic> makeOrderApiBody() {
    Map<String, dynamic> bodyRequest = {'require': {}};
    if (textFieldRequires.isNotEmpty) {
      for (int index = 0; index < textFieldRequires.length; index++) {
        bodyRequest['require'][textFieldRequires[index].name!] =
            requiresTextEditingControllersList[index].text;
      }
    }
    if (dropDownRequires.isNotEmpty) {
      for (int index = 0; index < dropDownRequires.length; index++) {
        //bodyRequest[dropDownRequires[index].name!]=dropDownSelectedValues[index];
        bodyRequest['quantity'] = dropDownSelectedValues[index];
      }
    }
    if (amountsRequires.isNotEmpty) {
      for (int index = 0; index < amountsRequires.length; index++) {
        //bodyRequest[amountsRequires[index].name!]=amountsTextEditingControllers[index].text;
        bodyRequest['quantity'] = amountsTextEditingControllers[index].text;
      }
    }
    if (quantityRequires.isNotEmpty) {
      for (int index = 0; index < quantityRequires.length; index++) {
        //bodyRequest[quantityRequires[index].name!]=quantityTextEditingControllers[index].text;
        bodyRequest['quantity'] = quantityTextEditingControllers[index].text;
      }
    }
    bodyRequest['product_id'] = product!.id;
    String uuid = const Uuid().v1();
    bodyRequest['order_uuid'] = uuid;
    if (otpEnabled == true) {
      bodyRequest['otp'] = otpTextController!.text;
    }
    print(bodyRequest);
    return bodyRequest;
  }


  fakeSubmit()async{

    roundedLoadingButtonController.start();
    await Future.delayed(const Duration(seconds: 4));
    roundedLoadingButtonController.stop();
  }

  submit() async {

    if (_validate()) {
      var currentRoute = Get.currentRoute;
      print('route1 = ${Get.currentRoute}');
      roundedLoadingButtonController.start();

      var response = await ApiRequest().post(
        path: '/order/add',
        body: makeOrderApiBody(),
        authRequire: true,
      );
      //print('stttttttttttttatus code : ${response.statusCode}');
      if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
        print('route2 = ${Get.currentRoute}');
        if (currentRoute == Get.currentRoute) {
          print('jjjjjjjjjjjjjjjjjj');
          Get.back(closeOverlays: true);
        }
        CustomSnackbar.show(
            title: 'Successes',
            description: 'Your purchase was completed successfully');
      }
      roundedLoadingButtonController.stop();
    }
  }



  getProductIfNeeded(String? productId)async{
    if(product==null && productId!=null){
      currentState.value=CurrentState.loading;
      dio.Response response = await ApiRequest().get(path: '/client/product/get/$productId');
      if(response.data['data']!=null && response.data['data']['available']==true){
        product = ProductModel.fromJson(response.data['data']);
        print('//////////////////${product?.productName}');
        print('//////////////////${product?.price}');
        print('//////////////////${product?.id}');
        update();

        currentState.value=CurrentState.full;
      }else{
        currentState.value=CurrentState.error;
      }

    }else{
      currentState.value=CurrentState.full;
    }
  }





  @override
  void onInit()async{
   await getProductIfNeeded(productId);
    if (Get.find<GlobalController>().userModel.value.otpEnable == 1) {
      otpEnabled = true;
    }
    if(product!=null){
      implementRequires();
    }
    super.onInit();
  }
}
