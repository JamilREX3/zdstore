import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zdstore/utils/api_request.dart';
import '../utils/enum_state.dart';
import 'package:dio/dio.dart' as dio;
import '../models/all_orders_log_model.dart';

class OrdersLogController extends GetxController {

  Rx<CurrentState> currentState = CurrentState.loading.obs;

  List<OrderModel> ordersList = [];
  //late TextEditingController searchTextController;
  String? selectedTimeKeyFilter;
  getOrdersLog({String? startTimeFilterParam})async{
    print('*********************************************');
    DateTime? finalStartTimeFilter;
    if(startTimeFilterParam==null && selectedTimeKeyFilter!=null){
      finalStartTimeFilter = dateFilterMap[selectedTimeKeyFilter];
    }else{
      finalStartTimeFilter = dateFilterMap[startTimeFilterParam];
      await GetStorage().write('selectedTimeKeyFilter', startTimeFilterParam);
      selectedTimeKeyFilter = startTimeFilterParam;
    }
    currentState.value = CurrentState.loading;
    dio.Response response = await ApiRequest().get(path: finalStartTimeFilter==null?'/order/all':'/order/all?start=$finalStartTimeFilter');
    if(response.statusCode.toString().startsWith(RegExp(r'2'))){
      ordersList = AllOrdersLogReq.fromJson(response.data).ordersList!;
      currentState.value = CurrentState.full;
    }else{
      currentState.value = CurrentState.error;
    }



  }
  searchOrderByNumber(String orderNumber)async{
    currentState.value = CurrentState.loading;
    dio.Response response  =await  ApiRequest().get(path: '/order/all?search=${orderNumber.toString()}');
    if(response.statusCode.toString().startsWith(RegExp(r'2'))){
      ordersList = AllOrdersLogReq.fromJson(response.data).ordersList!;
    }
    currentState.value = CurrentState.full;
  }
  Map<String,dynamic> dateFilterMap = {
    'All'.tr:DateTime(1960),
    'Today'.tr:DateTime.now().subtract(const Duration(hours: 24)),
    'Last 7 days'.tr:DateTime.now().subtract(const Duration(days: 7)),
    'Last 30 days'.tr:DateTime.now().subtract(const Duration(days: 30)),
  };
  init(){
    selectedTimeKeyFilter = GetStorage().read('selectedTimeKeyFilter');
    getOrdersLog();
  }
  @override
  void onInit() {

    init();
    super.onInit();
  }






}