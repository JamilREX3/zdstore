import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zdstore/utils/enum_state.dart';
import 'package:dio/dio.dart' as dio;
import 'package:zdstore/views/auth_view.dart';
import '../components/custom_snackbar.dart';
import '../models/country_model.dart';
import '../utils/api_request.dart';

class SetInfoController extends GetxController {
  List<CountryModel>? countriesList;
  Rx<CurrentState> currentState = CurrentState.loading.obs;
  Rx<CountryModel>? selectedCountryModel;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController agentController = TextEditingController();

  init() async {
    if (currentState.value != CurrentState.loading) {
      currentState.value = CurrentState.loading;
    }
    print('kk');
    await getCountries();
    currentState.value = CurrentState.full;
  }

  _validateFields() {
    if (phoneController.text.isEmpty || selectedCountryModel == null) {
      CustomSnackbar.show(
          title: 'Error', description: 'Please fill in all fields');
      return false;
    }
    return true;
  }

  Future<void> getCountries() async {
    countriesList = [];
    dio.Response response = await ApiRequest().get(path: '/country/all');
    if (response.statusCode! >= 200) {
      countriesList = CountryModelReq.fromJson(response.data).countriesList!;
    }
  }

  submitInfo() async {
    if (_validateFields()) {
      currentState.value = CurrentState.loading;
      dio.Response response = await ApiRequest().post(path: '/info', body: agentController.text.isEmpty?{
        'country_id': selectedCountryModel!.value.id,
        'currency_id': selectedCountryModel!.value.currencyId,
        'phone': phoneController.text,
        'calling_code': selectedCountryModel!.value.callingCode,
      }:{
        'country_id': selectedCountryModel!.value.id,
        'currency_id': selectedCountryModel!.value.currencyId,
        'phone': phoneController.text,
        'calling_code': selectedCountryModel!.value.callingCode,
        'agent_ref':agentController.text,
      });
      if (response.statusCode! >= 200) {
        Get.offAll(const AuthView());
      }
    }
  }

  @override
  void onInit() {
    print('oooooooooooooooooooo');
    init();
    super.onInit();
  }
}
