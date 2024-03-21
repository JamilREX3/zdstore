import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zdstore/themes/my_theme.dart';

class MyThemeController extends GetxController {
  final RxBool isDarkMode = false.obs;
  // final RxString language = 'en'.obs;
  final _box = GetStorage();


  ThemeData get lightThemeData {
    bool isArabic = Get.locale?.languageCode == 'ar';
    if(isArabic==true){
      return lightTheme('ar');
    }else{
      return lightTheme('en');
    }
  }

  ThemeData get darkThemeData {
    bool isArabic = Get.locale?.languageCode == 'ar';
    if(isArabic==true){
      return darkTheme('ar');
    }else{
      return darkTheme('en');
    }

  }

  @override
  void onInit() {
    _loadThemeMode();
    super.onInit();

    // _loadLanguage();
  }

  void changeTheme(bool isDarkModeParam) async{
    print(isDarkModeParam);

    if(isDarkModeParam==true){
      Get.changeThemeMode(ThemeMode.dark);
      isDarkMode.value = isDarkModeParam;
      //Get.changeTheme(darkThemeData);
    }else{
      Get.changeThemeMode(ThemeMode.light);
      isDarkMode.value = isDarkModeParam;
     //Get.changeTheme(lightThemeData);

    }
    await GetStorage().write('isDarkMode', isDarkModeParam);
    // update();
    update();
    //Get.find<GlobalController>().update();
  }

  void changeLanguage(String languageCode , String countryCode ){
    // Get.updateLocale(const Locale('ar','SY'));
    Get.updateLocale( Locale(languageCode,countryCode));
   // language.value = languageCode;
    _box.write('language', languageCode);
  }

  void _loadThemeMode() {
    var tt = GetStorage().read('isDarkMode');
    print('oooooooooooooooooo${tt}oooooooooooooooooooo');
    isDarkMode.value = _box.read('isDarkMode') ?? false;

  }

  // void _loadLanguage() {
  //   language.value = _box.read('language')??'en';
  // }
}
