

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:url_launcher/url_launcher.dart';
import 'package:zdstore/utils/api_request.dart';
import '../models/agents_model.dart';
import '../utils/enum_state.dart';

class AgentsController extends GetxController {
  Rx<CurrentState> currentState = CurrentState.loading.obs;

  List<AgentModel> agentsList = [];


  getAgentsList()async{
    currentState.value=CurrentState.loading;
    dio.Response response = await ApiRequest().get(path: '/agents');
    if(response.statusCode.toString().startsWith(RegExp(r'2')) && response.data['data']!=null && response.data['data']!=[]){
      agentsList = AgentsModelReq.fromJson(response.data).agentsModelList!;
      currentState.value = CurrentState.full;
    }
   else{
     currentState.value = CurrentState.error;
    }
  }

  void launchWhatsApp({
    required String phone,
  }) async {
    String url = "https://wa.me/$phone";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch ${Uri.parse(url)}';
    }
  }


  void makeCall({required String phoneNumber})async {
    String url = 'tel:+$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch ${Uri.parse(url)}';
    }
  }


  init(){
    getAgentsList();
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }


}