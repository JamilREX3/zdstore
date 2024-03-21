import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class CustomSnackbar {
  static void show(
      {dio.Response? response,
        String? title,
        Color? colorText,
        String? description,
        Color backgroundColor = Colors.red}) {




    // Set default background color based on theme
    backgroundColor = Get.isDarkMode==true ? Colors.indigo : Colors.purple;

    // Check if response is not null
    if(response?.statusCode==204){
      backgroundColor = Colors.indigo;
      title = 'Successes';
      description = 'Deleted successfully';
    }



    else if (response != null && response.data!=null) {
      // print(response.data);
      // Check if response contains an 'errors' array
      print(response.data);
      if(response.headers['content-type'].toString().contains('text/html')){
        backgroundColor = Colors.red;
        title = 'Error';
        description = 'An error occurred';
      }
      else if (response.data['errors'] != null && response.data['errors'].isNotEmpty) {
        // Get the first error from the 'errors' array
        var error = response.data['errors'][0];
        backgroundColor = Colors.red;
        title = 'Failed';
        description = error['msg'];
      }
      // Check if status code starts with 4 or 5
      else if (response.statusCode.toString().startsWith(RegExp(r'[345]'))) {
        backgroundColor = Colors.red;
        title = 'Failed';
        description = response.data['msg'] ?? response.data['message'];
        //return;
      } else if(response.statusCode.toString().startsWith(RegExp(r'[1]'))){
        print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
        // no wifi no mobile data
        // backgroundColor = Colors.red;
        // title = 'No Internet';
        // description = 'Please check your internet connection';
        //Get.snackbar('iii', 'ffff');
        //return;
       // return;
        return;
      }else{
        print('nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnoneeeeee');
        return;
      }
    }
    print('bbbbbbbbbbefore');

    Get.snackbar(
      title!=null?title.tr:'',
      description!=null?description.tr: '',
      backgroundColor: backgroundColor,
      colorText : colorText ?? Colors.white,
    );
    print('afteeeeeeeeeeeeer');
  }
}