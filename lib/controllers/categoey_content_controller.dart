


import 'package:get/get.dart';

import '../models/home_content_model.dart';
import '../utils/api_request.dart';
import '../utils/enum_state.dart';

class CategoryContentController extends GetxController {

  Rx<CurrentState> currentState = CurrentState.loading.obs;

  Rx<CategoryContentModel> categoryContent = CategoryContentModel().obs;

  List<Sortable> sortedContent = [];


  Future<void> getCategoryContent(String categoryId) async {
    currentState.value = CurrentState.loading;
    var response =
    await ApiRequest().get(path: '/category/products/$categoryId');
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      categoryContent.value =
      CategoryContentModelReq.fromJson(response.data).homeContentModel!;
    }

    List<Sortable> items = [];
    items.addAll(categoryContent.value.products!);
    items.addAll(categoryContent.value.categories!);
    items.sort((a, b) => a.sortValue!.compareTo(b.sortValue!));
    sortedContent = items;
    for (var x in items) {
      if (x is ProductModel) {
        print('sort = ${x.sort} - ${x.productName} as product');
      } else if (x is CategoryModel) {
        print('sort = ${x.sort} - ${x.name} as category');
      }
    }
    currentState.value = CurrentState.full;
  }
}