import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zdstore/models/alerts_model.dart';
import 'package:zdstore/models/app_info_model.dart';
import 'package:zdstore/utils/api_request.dart';
import 'package:dio/dio.dart' as dio;
import 'package:zdstore/views/favourite_view.dart';
import 'package:zdstore/views/global_search_view.dart';
import 'package:zdstore/views/home_view/home_view.dart';
import 'package:zdstore/views/orders_view/orders_log_view.dart';
import '../models/user_model.dart';
import '../themes/theme_controller.dart';
import '../views/transactions_view/transactions_view.dart';

class GlobalController extends GetxController {
  late var index = 0.obs;
  var title = 'Home'.tr.obs;
  final Rx<UserModel> userModel;

  late final ZoomDrawerController zoomDrawerController;

  late AppInfoModel appInfoModel;


  GlobalController(UserModel userModel) : userModel = userModel.obs;


  changeIndex(int value){
    index.value = value;
  }
  navBarTrigger({ bool? refresh}){
    // if(refresh==true){
    //   value=index.value;
    // }
    print('hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    switch (index.value){
      case 0 : {
        title.value = 'Home'.tr;
      }
      case 1 :{
        title.value = 'Budget'.tr;
      }
      case 2 :{
        title.value = 'Favourite'.tr;
      }
      case 3 :{
        title.value = 'Orders'.tr;
        if(refresh==true){
          //Get.find<OrdersLogController>().init();
        }
      }
      case 4 :{
        title.value = 'Search'.tr;
      }
    }
  }


  final List<Widget> items = [
    const Icon(Icons.home,),
    const Icon(Icons.account_balance_wallet_rounded),
    const Icon(Icons.favorite_rounded),
    const Icon(Icons.shopping_cart_rounded),
    const Icon(Icons.search_rounded),
  ];

  List<Widget> screens = [
    const HomeView(),
    const TransactionsView(),
    const FavouriteView(),
    const OrdersLogView(),
    const GlobalSearchView(),
  ];

  getAlerts() async {
    print('hiiiiiiiiiiiiiiiiiiiiiiii');
    var tempFromStorage = GetStorage().read('alertsList');
    late List<int> oldAlertsId;
    if(tempFromStorage==null){
      oldAlertsId = [];
    }else{
      oldAlertsId=tempFromStorage.cast<int>();
    }

    changeTheme(){
      if(Get.isDarkMode){
        Get.changeThemeMode(ThemeMode.light);
        Get.changeTheme(Get.find<MyThemeController>().lightThemeData);
      }else{
        Get.changeThemeMode(ThemeMode.dark);
        Get.changeTheme(Get.find<MyThemeController>().darkThemeData);
      }
    }

      //List<int>? oldAlertsId = GetStorage().read('alertsList');
    dio.Response response = await ApiRequest().get(path: '/alert');
    print(response.statusCode);
    print(response.data);
    if (response.statusCode! >= 200) {
      List<int> newList = [];
      List<AlertModel>? alertsFromApi =
          AlertsReq.fromJson(response.data).alertsList;
      if (oldAlertsId.isNotEmpty == true &&
          alertsFromApi?.isNotEmpty == true) {
        print('p111111111111111111111111111');
        newList = alertsFromApi!
            .map((AlertModel e) => e.id!)
            .toList()
            .where((int element) => !oldAlertsId.contains(element))
            .toList();
      } else if (oldAlertsId.isEmpty == true &&
          alertsFromApi?.isNotEmpty == true) {
        oldAlertsId = [];
        newList = AlertsReq.fromJson(response.data)
            .alertsList!
            .map((e) => e.id!)
            .toList();
      }
      List<AlertModel> filteredAlert =
          alertsFromApi!.where((alert) => newList.contains(alert.id)).toList();

      if(filteredAlert.isNotEmpty){
        Get.defaultDialog(
          // store the list in storage
            onWillPop: () async {
              List<int> temp = newList + oldAlertsId;
              await GetStorage().write('alertsList', temp);

              return true;
            },
            title: '',
            content: Column(
              children: [
                ...filteredAlert.map((alert) => HtmlWidget(alert.body!)).toList(),
              ],
            ));
      }
    }
  }

  getAppInfo()async{
    var response = await ApiRequest().get(path: '/configs');
    if(response.statusCode.toString().startsWith(RegExp(r'2'))){
      appInfoModel = AppInfoReq.fromJson(response.data).appInfo!;
    }
  }




  @override
  void onInit() {
    zoomDrawerController = ZoomDrawerController();
    getAlerts();
    getAppInfo();
    super.onInit();
  }


}
