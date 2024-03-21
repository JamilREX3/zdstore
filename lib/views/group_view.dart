

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zdstore/controllers/group_controller.dart';

import '../components/custom_text.dart';
import '../utils/enum_state.dart';


class GroupView extends StatelessWidget {
  const GroupView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GroupController());
    return GetBuilder<GroupController>(builder: (controller)=>Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const CustomText('Account rank'),
      ),
      body:  Obx(() {
        CurrentState currentState = controller.currentState.value;
        return currentState == CurrentState.loading
            ? const Center(child: CircularProgressIndicator())
            : currentState == CurrentState.full
            ?  Column(
          children: [
            Card(
              child: Row(
                children: [
                 // controller.userModel.groupLogo!.contains('svg')==true?SvgPicture.network('${KConstants.imageBaseUrl}/${controller.userModel.groupLogo}',height: 40,width: 40):Image.network('${KConstants.imageBaseUrl}/${controller.userModel.groupLogo}' ,height: 40,width: 40,),
                ],
              ),
            )
          ],
        )
            : currentState == CurrentState.error
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText('Error'),
              ElevatedButton(
                  onPressed: () {
                    controller.init();
                  },
                  child: const CustomText('Try again')),
            ],
          ),
        )
            : const SizedBox();
      }),
    ));
  }
}
