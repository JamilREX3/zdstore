import 'package:flutter/material.dart';

ThemeData lightTheme(String language){
  return ThemeData.light(useMaterial3: true).copyWith(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade100,
      selectedItemColor: Colors.indigo,
      unselectedItemColor: Colors.grey,
    ),
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light().copyWith(
    ),
    textTheme:  ThemeData.light().textTheme.apply(
      fontFamily:'tajawal',
    ),
    primaryTextTheme: ThemeData.light().textTheme.apply(
      fontFamily:'tajawal',
    ),
  );
}

ThemeData darkTheme(String language){
  return ThemeData.dark(useMaterial3: true).copyWith(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.indigoAccent.shade100,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.shifting,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    brightness: Brightness.dark,
    textTheme:  ThemeData.dark().textTheme.apply(
      fontFamily:'tajawal',
    ),
    primaryTextTheme: ThemeData.dark().textTheme.apply(
      fontFamily:'tajawal',
    ),
    /* light theme settings */
  );
}
















// final ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
//   brightness: Brightness.dark,
//   textTheme: GetStorage().read('language')=='ar'? ThemeData.dark().textTheme.apply(
//     fontFamily: 'tajawal',
//   ):GoogleFonts.robotoTextTheme(
//     Get.textTheme,
//   ),
//   primaryTextTheme: GetStorage().read('language')=='ar'? ThemeData.dark().textTheme.apply(
//     fontFamily: 'tajawal',
//   ):GoogleFonts.robotoTextTheme(
//     Get.textTheme,
//   ),
//   /* dark theme settings */
// );

