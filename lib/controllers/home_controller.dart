import 'package:get/get.dart';
import 'package:zdstore/utils/api_request.dart';

import '../models/home_content_model.dart';
import '../utils/enum_state.dart';

class HomeController extends GetxController {

  Rx<CurrentState> currentState = CurrentState.loading.obs;

  Rx<CategoryContentModel> homeContentModel = CategoryContentModel().obs;

  List<Sortable> sortedContent = [];


  Future<void> getHomeContent() async {
    currentState.value = CurrentState.loading;
    var response =
    await ApiRequest().get(path: '/category/products/0');
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      homeContentModel.value =
      CategoryContentModelReq.fromJson(response.data).homeContentModel!;
      List<Sortable> items = [];
      items.addAll(homeContentModel.value.products!);
      items.addAll(homeContentModel.value.categories!);
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
    }else if(response.statusCode==1000){
      currentState.value=CurrentState.error;
    }
  }



  @override
  void onInit() async{
   await getHomeContent();
    // opacities = List.filled(sortedContent.length, 0.0);
    // for (int i = 0; i < opacities.length; i++) {
    //   Future.delayed(Duration(milliseconds: 100 * i), () {
    //     opacities[i] = 1.0;
    //     update();
    //   });
    // }
    super.onInit();
  }

}
