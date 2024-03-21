

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/notifications_model.dart';
import '../utils/api_request.dart';
import '../utils/enum_state.dart';
import 'package:dio/dio.dart'as dio;
class NotificationsLogController extends GetxController{
  Rx<CurrentState> currentState = CurrentState.loading.obs;
  List<NotificationModel> notificationsList = [];

  String? selectedTimeKeyFilter;

  getNotificationsLog({String? startTimeFilterParam})async{
    print('*********************************************');
    DateTime? finalStartTimeFilter;
    if(startTimeFilterParam==null && selectedTimeKeyFilter!=null){
      finalStartTimeFilter = dateFilterMap[selectedTimeKeyFilter];
    }else{
      finalStartTimeFilter = dateFilterMap[startTimeFilterParam];
      await GetStorage().write('NotificationsSelectedTimeKeyFilter', startTimeFilterParam);
      selectedTimeKeyFilter = startTimeFilterParam;
    }
    currentState.value = CurrentState.loading;
    dio.Response response = await ApiRequest().get(path: finalStartTimeFilter==null?'/notification/all':'/notification/all?start=$finalStartTimeFilter');
    if(response.statusCode.toString().startsWith(RegExp(r'2'))){
      notificationsList = NotificationsModelReq.fromJson(response.data).notificationsList!;
      currentState.value = CurrentState.full;
    }else if(response.statusCode==1000){
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
    selectedTimeKeyFilter = GetStorage().read('NotificationsSelectedTimeKeyFilter');
    getNotificationsLog();
  }



  // @override
  // void onInit() {
  //   init();
  //   super.onInit();
  // }

}