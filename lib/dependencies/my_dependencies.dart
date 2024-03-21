


import 'package:get/get.dart';
import 'package:zdstore/themes/theme_controller.dart';
import 'package:zdstore/utils/connection_manager_controller.dart';

//final ThemeController _themeController = Get.put(ThemeController());


class MyDependencies extends Bindings {
  @override
  void dependencies() {
    Get.put(()=>MyThemeController());
    Get.put(ConnectionManagerController());
  }
  
}