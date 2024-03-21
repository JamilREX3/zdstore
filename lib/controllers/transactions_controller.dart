

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zdstore/models/transactions_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:zdstore/utils/api_request.dart';
import '../utils/enum_state.dart';

class TransactionsController extends GetxController {

  Rx<CurrentState> currentState = CurrentState.loading.obs;

  TranActionsFullModel tranActionsFullModel = TranActionsFullModel();

  String? selectedTimeKeyFilter;

  getTransactions({String? startTimeFilterParam})async{
    DateTime? finalStartTimeFilter;
    if(startTimeFilterParam==null && selectedTimeKeyFilter!=null){
      finalStartTimeFilter = dateFilterMap[selectedTimeKeyFilter];
    }else{
      finalStartTimeFilter = dateFilterMap[startTimeFilterParam];
      await GetStorage().write('TransactionsSelectedTimeKeyFilter', startTimeFilterParam);
      selectedTimeKeyFilter = startTimeFilterParam;
    }
    currentState.value = CurrentState.loading;
    dio.Response response = await ApiRequest().get(path: finalStartTimeFilter==null?'/transfer/all':'/transfer/all?start=$finalStartTimeFilter');
    if(response.statusCode.toString().startsWith(RegExp(r'2'))){
      tranActionsFullModel = TransactionsModelReq.fromJson(response.data).tranActionsFullModel!;
      currentState.value = CurrentState.full;
    }else{
      currentState.value = CurrentState.error;
    }

  }


  Map<String,dynamic> dateFilterMap = {
    'All'.tr:DateTime(1960),
    'Today'.tr:DateTime.now().subtract(const Duration(hours: 24)),
    'Last 7 days'.tr:DateTime.now().subtract(const Duration(days: 7)),
    'Last 30 days'.tr:DateTime.now().subtract(const Duration(days: 30)),
  };



  init(){
    selectedTimeKeyFilter = GetStorage().read('TransactionsSelectedTimeKeyFilter');
    getTransactions();
  }


  @override
  void onInit() {
    init();
    super.onInit();
  }



}