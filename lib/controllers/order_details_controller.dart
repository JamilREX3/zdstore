import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zdstore/models/order_details_model.dart';
import 'package:zdstore/utils/api_request.dart';

import '../components/custom_snackbar.dart';
import '../utils/enum_state.dart';

class OrderDetailsController extends GetxController with GetSingleTickerProviderStateMixin {
  final String orderId;

  OrderDetailsController({required this.orderId});

  Rx<CurrentState> currentState = CurrentState.loading.obs;
  late OrderDetailsModel orderDetailsModel;


  TextEditingController? objectionTextEditingController;


  RxBool objectionPressed = false.obs;

  // OrderDe

  getOrderDetails() async {
    currentState.value = CurrentState.loading;
    var response = await ApiRequest().get(path: '/order/get/$orderId');
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      orderDetailsModel =
          OrderDetailsReq.fromJson(response.data).orderDetailsModel!;
    }
    currentState.value = CurrentState.full;
  }

  bool _validate() {
    if (objectionTextEditingController?.text.isEmpty == true) {
      CustomSnackbar.show(
          title: 'Error', description: 'Please fill in all fields');
      return false;
    }
    return true;
  }

  makeObjection() async {
    Get.closeAllSnackbars();
    if (_validate()) {
      if(Get.isDialogOpen==true){
        Get.back();
      }
      currentState.value = CurrentState.loading;
      await ApiRequest().post(path: '/order/objection', body: {
        'order_id': orderDetailsModel.id,
        'replay': objectionTextEditingController!.text,
      });
      getOrderDetails();
    }
  }

  cancelOrder()async{
    currentState.value = CurrentState.loading;
    await ApiRequest().post(path: '/order/cancel',body: {
      'id':orderDetailsModel.id,
    });
    getOrderDetails();
  }



  @override
  void onInit() {
    getOrderDetails();
    super.onInit();
  }










}
