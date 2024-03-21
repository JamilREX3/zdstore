import 'package:get/get.dart';
import '../models/group_model.dart';
import '../utils/api_request.dart';
import '../utils/enum_state.dart';

class GroupController extends GetxController {

  Rx<CurrentState> currentState = CurrentState.loading.obs;
  List<GroupModel> groups = [];

  GroupModel? myGroup;
  num? totalPurchases;

  getGroupsAndTotalPurchases() async {
    currentState.value = CurrentState.loading;
    var response = await ApiRequest().get(path: '/groups/client');
    if (response.statusCode.toString().startsWith(RegExp(r'2')) &&
        response.data['data'] != null &&
        response.data['data'] != []) {
      groups = GroupModelReq.fromJson(response.data).data!.groups!;
      totalPurchases =
          GroupModelReq.fromJson(response.data).data?.totalPurchases;



      
      if(totalPurchases!.toDouble() < 600){
        myGroup = groups[0];
      }else if(totalPurchases!.toDouble() < 2000){
        myGroup = groups[1];
      }else{
        myGroup = groups[2];
      }








      currentState.value = CurrentState.full;
    } else {
      currentState.value = CurrentState.error;
    }
    update();
  }
  init() {
    getGroupsAndTotalPurchases();
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
