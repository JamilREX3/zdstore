import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:zdstore/models/global_search_model.dart';
import '../utils/api_request.dart';
import '../utils/enum_state.dart';

class GlobalSearchController extends GetxController {
  Rx<CurrentState> currentState = CurrentState.init.obs;
  TextEditingController searchTextEditingController = TextEditingController();
  GlobalSearchModel globalSearchController =
      GlobalSearchModel(searchOrdersList: [], searchProductsList: []);

  getResult(String keyword) async {
    globalSearchController =
        GlobalSearchModel(searchOrdersList: [], searchProductsList: []);
    currentState.value = CurrentState.loading;
    dio.Response response =
        await ApiRequest().get(path: '/client/search/$keyword');
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      globalSearchController =
          GlobalSearchModelReq.fromJson(response.data).globalSearchModel!;
    }
    if (globalSearchController.searchProductsList?.isEmpty == true &&
        globalSearchController.searchOrdersList?.isEmpty == true) {
      currentState.value = CurrentState.empty;
    } else {
      currentState.value = CurrentState.full;
    }
    update();
  }
}
