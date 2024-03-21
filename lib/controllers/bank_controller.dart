import 'package:get/get.dart';
import 'package:zdstore/models/bank_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:zdstore/models/currency_model.dart';
import '../utils/api_request.dart';
import '../utils/enum_state.dart';

class BankController extends GetxController {
  Rx<CurrentState> currentState = CurrentState.loading.obs;
  var hasError = false.obs;

  List<BankModel> banksList = [];
  List<CurrencyModel> currenciesList = [];

  Future<void> getBanksList() async {
    currentState.value = CurrentState.loading;
    dio.Response response = await ApiRequest().get(path: '/banks');
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      banksList = BankModelReq.fromJson(response.data).banksList!;
      if (!hasError.value) {
        currentState.value = CurrentState.full;
      }
    } else {
      currentState.value = CurrentState.error;
      hasError.value = true;
    }
  }

  Future<void> getCurrencies() async {
    dio.Response response =
    await ApiRequest().get(path: '/currencies/client/all');
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      currenciesList = CurrencyModelReq.fromJson(response.data).currenciesList!;
      if (!hasError.value) { // Add this line
        currentState.value = CurrentState.full;
      }
    } else {
      currentState.value = CurrentState.error;
      hasError.value = true; // Add this line
    }
  }

  init() async {
    await Future.wait([getBanksList(), getCurrencies()]);
    update();
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
