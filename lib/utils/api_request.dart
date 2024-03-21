import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:zdstore/utils/connection_manager_controller.dart';
import 'package:zdstore/utils/my_response_handler.dart';
import '../components/custom_snackbar.dart';
import '../constants/k_constants.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';

class ApiRequest{
  final _dio = dio.Dio();
  final ConnectionManagerController _connectionManagerController = Get.find();




  // ApiRequest() {
  //
  //   _dio.interceptors.add(
  //     dio.InterceptorsWrapper(
  //       onRequest: (dio.RequestOptions options, dio.RequestInterceptorHandler handler) async {
  //         if (_connectionManagerController.connectionType.value == 0) {
  //           // No internet connection
  //           // Show a message to the user
  //           CustomSnackbar.show(title: 'No Internet' , description: 'Please check your internet connection',backgroundColor: Colors.red);
  //           //Get.snackbar('No Internet', 'Please check your internet connection');
  //           throw dio.DioException(
  //             requestOptions: options,
  //             error: 'No Internet',
  //           );
  //         } else {
  //           return handler.next(options);
  //         }
  //       },
  //     ),
  //   );
  // }


  // ApiRequest() {
  //   _dio.interceptors.add(
  //     dio.InterceptorsWrapper(
  //       onRequest: (dio.RequestOptions options, dio.RequestInterceptorHandler handler) async {
  //         if (_connectionManagerController.connectionType.value == 0) {
  //           // No internet connection
  //           // Show a message to the user
  //           Get.snackbar('No Internet', 'Please check your internet connection');
  //           //handler.reject('No Internet');
  //         } else {
  //           return handler.next(options);
  //         }
  //       },
  //     ),
  //   );
  // }








  Future<dio.Response> get(
      {authRequire = true,
      @required path,
      dynamic body,
      Map<String, dynamic>? query,
      bool showSnackBar = true}) async {
    dio.Response finalResponse;
    //
    // print(_connectionManagerController.isConnected.value);
    // if (!_connectionManagerController.isConnected.value) {
    //   print('-----------------------------------------------');
    //   finalResponse = dio.Response(
    //     statusCode: 1000,
    //     data: {'message': 'An error occurred'},
    //     requestOptions: dio.RequestOptions(path: KConstants.baseUrl + path),
    //   );
    //   if (showSnackBar == true) {
    //     print('44444');
    //     CustomSnackbar.show(response: finalResponse);
    //   }
    //   //CustomSnackbar.show(title: 'No Internet',description: 'Please check your internet connection');
    //   return finalResponse;
    // }








    try {
      dio.Options options = dio.Options();
      String language = GetStorage().read('language') == 'ar' ? 'ar' : 'en';
      query ??= {};
      query['lang'] = language;
      if (authRequire == true) {
        String token = await GetStorage().read('token');
        options = dio.Options(headers: {'Authorization': 'Bearer $token'});
      }
      dio.Response response = await _dio.get(
        KConstants.baseUrl + path,
        data: body,
        queryParameters: query,
        options: options,
      );
      print('url = ${response.realUri}');
      print('status code = ${response.statusCode}');
      print('body = ${response.data}');
      finalResponse = response;
    } on dio.DioException catch (e) {
      if (e.response != null) {
        print('my api error = ${e.response}');
        print('my api error = ${e.error}');
        print('my api error = ${e.type}');
        print('my api error = ${e.message}');
        print('my api error = ${e.stackTrace}');
        print('my api error = ${e.requestOptions}');
        finalResponse = e.response!;
        MyResponseHandler.handle(e.response!);
      } else {
        finalResponse = dio.Response(
          statusCode: 1000,
          data: {'message': 'An error occurred'},
          requestOptions: dio.RequestOptions(path: KConstants.baseUrl + path),
        );
      }
    }
    if (showSnackBar == true) {
      CustomSnackbar.show(response: finalResponse);
    }
    return finalResponse;
  }

  Future<dio.Response> post(
      {authRequire = true,
      @required path,
      dynamic body,
      Map<String, dynamic>? params}) async {
    dio.Response finalResponse;


    try {
      dio.Options options = dio.Options();
      if (authRequire == true) {
        String token = await GetStorage().read('token');
        options = dio.Options(headers: {'Authorization': 'Bearer $token'});
      }

      if (body != null) {
        bool hasFileData = false;
        dio.FormData formData = dio.FormData.fromMap(body);
        body.forEach((key, value) async {
          if (value is File || value is XFile) {
            hasFileData = true;
            final mimeType = lookupMimeType(value.path);
            formData.files.add(MapEntry(
                key,
                await dio.MultipartFile.fromFile(value.path,
                    filename: key, contentType: MediaType.parse(mimeType!))));
          }
        });
        if (hasFileData) {
          body = formData;
        }
      }

      dio.Response response = await _dio.post(
        KConstants.baseUrl + path,
        data: body,
        queryParameters: params,
        options: options,
      );

      finalResponse = response;
    } on dio.DioException catch (e) {
      if (e.response != null) {
        print('my api error = ${e.response}');
        print('my api error = ${e.error}');
        print('my api error = ${e.type}');
        print('my api error = ${e.message}');
        print('my api error = ${e.stackTrace}');
        print('my api error = ${e.requestOptions}');
        MyResponseHandler.handle(e.response!);
        finalResponse = e.response!;
      } else {

        finalResponse = dio.Response(
          statusCode: 1000,
          data: {'message': 'An error occurred'},
          requestOptions: dio.RequestOptions(path: KConstants.baseUrl + path),
        );

      }
    }
    CustomSnackbar.show(response: finalResponse);
    return finalResponse;
  }

  Future<dio.Response> put(
      {authRequire = true,
      @required path,
      dynamic body,
      Map<String, dynamic>? params}) async {
    dio.Response finalResponse;
    try {
      dio.Options options = dio.Options();
      if (authRequire == true) {
        String token = await GetStorage().read('token');
        options = dio.Options(headers: {'Authorization': 'Bearer $token'});
      }
      if (body != null) {
        bool hasFileData = false;
        dio.FormData formData = dio.FormData.fromMap(body);
        body.forEach((key, value) async {
          if (value is File || value is XFile) {
            hasFileData = true;
            final mimeType = lookupMimeType(value.path);
            formData.files.add(MapEntry(
                key,
                await dio.MultipartFile.fromFile(value.path,
                    filename: key, contentType: MediaType.parse(mimeType!))));
          }
        });
        if (hasFileData) {
          body = formData;
        }
      }

      dio.Response response = await _dio.put(
        KConstants.baseUrl + path,
        data: body,
        queryParameters: params,
        options: options,
      );

      finalResponse = response;
    } on dio.DioException catch (e) {
      if (e.response != null) {
        MyResponseHandler.handle(e.response!);
        finalResponse = e.response!;
      } else {
        finalResponse = dio.Response(
          statusCode: 1000,
          data: {'message': 'An error occurred'},
          requestOptions: dio.RequestOptions(path: KConstants.baseUrl + path),
        );

      }
    }
    CustomSnackbar.show(response: finalResponse);
    return finalResponse;
  }

  Future<dio.Response> delete(
      {authRequire = true,
      @required path,
      Map<String, dynamic>? params}) async {
    dio.Response finalResponse;
    try {
      dio.Options options = dio.Options();
      if (authRequire == true) {
        String token = await GetStorage().read('token');
        options = dio.Options(headers: {'Authorization': 'Bearer $token'});
      }
      dio.Response response =
          await _dio.delete(KConstants.baseUrl + path, options: options);

      finalResponse = response;
    } on dio.DioException catch (e) {
      if (e.response != null) {
        MyResponseHandler.handle(e.response!);
        finalResponse = e.response!;
      } else {
        finalResponse = dio.Response(
          statusCode: 1000,
          data: {'message': 'An error occurred'},
          requestOptions: dio.RequestOptions(path: KConstants.baseUrl + path),
        );
        // if (!_connectionManagerController.isConnected.value) {
        //   // No internet connection
        //   // Show a message to the user
        //   //Get.snackbar('No Internet', 'Please check your internet connection');
        //   // You can return a custom response or throw an error here
        //   // For example:
        //   finalResponse =  dio.Response(
        //     statusCode: 1000,
        //     data: {'message': 'No Internet'},
        //     requestOptions: dio.RequestOptions(path: KConstants.baseUrl + path),
        //   );
        // }else{
        //   finalResponse = dio.Response(
        //     statusCode: 500,
        //     data: {'message': 'An error occurred'},
        //     requestOptions: dio.RequestOptions(path: KConstants.baseUrl + path),
        //   );
        // }

      }
    }

    CustomSnackbar.show(response: finalResponse);
    return finalResponse;
  }
}
