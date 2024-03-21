import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zdstore/dependencies/my_dependencies.dart';
import 'package:zdstore/themes/theme_controller.dart';
import 'package:zdstore/translation/my_translations.dart';
import 'package:zdstore/views/auth_view.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Locale getLocaleFromStorage() {
      dynamic language = GetStorage().read('language');
      if (language == 'ar') {
        return Locale(language);
      } else {
        return const Locale('en');
      }
    }

    getIsDarkMode() {
      var temp = GetStorage().read('isDarkMode');
      print('temp = $temp');
      if (temp == null || temp == false) {
        return false;
      } else {
        return true;
      }
    }

    Get.put(MyThemeController());
    return GetMaterialApp(
      routingCallback: (route) {
        // print('---------->${route?.current}');
        // if(route?.current=='/GlobalView' && route?.isBack==true){
        //   Get.find<GlobalController>().navBarTrigger(refresh: true);
        // }
      },
      debugShowCheckedModeBanner: false,
      title: 'ZD Store',
      initialBinding: MyDependencies(),
      translations: MyTranslations(),
      locale: getLocaleFromStorage(),
      theme: Get.find<MyThemeController>().lightThemeData,
      darkTheme: Get.find<MyThemeController>().darkThemeData,
      themeMode: getIsDarkMode() ? ThemeMode.dark : ThemeMode.light,
      home: const AuthView(),
    );
  }
}
