import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zdstore/components/custom_text.dart';
import 'package:zdstore/controllers/notifications_log_controller.dart';
import 'package:zdstore/utils/enum_state.dart';
import 'package:zdstore/views/notifications_log_view/notification_tile.dart';

class NotificationsLogView extends StatelessWidget {
  const NotificationsLogView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Get.put(NotificationsLogController());
    return GetBuilder<NotificationsLogController>(
      initState: (_){
        Get.find<NotificationsLogController>().init();
      },
        builder: (controller) =>
          Scaffold(
            extendBody: true,
            appBar: AppBar(
              //backgroundColor: Colors.transparent,
              forceMaterialTransparency: true,
              centerTitle: true,
              title: const CustomText('Notifications'),

              // actions: [
              //   IconButton(onPressed: (){
              //     Get.to(NotificationsLogView());
              //   }, icon: Icon(Icons.notifications_rounded))
              // ],
            ),
            body:  Obx(
                    (){
                  CurrentState currentState = controller.currentState.value;
                  return  currentState == CurrentState.loading
                      ? const Center(child: CircularProgressIndicator())
                      :currentState==CurrentState.full? RefreshIndicator(
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    focusColor: Colors.transparent,
                                    //  labelText: widget.labelText,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    //filled: true,
                                    contentPadding:
                                    const EdgeInsets.fromLTRB(10, 16, 16, 0),
                                    fillColor: Colors.white24,
                                  ),
                                  focusColor: Colors.transparent,
                                  focusNode: FocusNode(
                                      skipTraversal: true,
                                      canRequestFocus: false,
                                      descendantsAreFocusable: false,
                                      descendantsAreTraversable: false),
                                  isExpanded: true,
                                  value: controller.dateFilterMap.keys.firstWhere(
                                          (key) =>
                                      key == controller.selectedTimeKeyFilter,
                                      orElse: () =>
                                      controller.dateFilterMap.keys.first),
                                  icon: const Icon(Icons.arrow_drop_down_outlined),
                                  onChanged: (dynamic newValue) {
                                    controller.getNotificationsLog(
                                        startTimeFilterParam: newValue);
                                  },
                                  items: controller.dateFilterMap.keys
                                      .toList()
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: CustomText(value),
                                    );
                                  }).toList(),
                                )),
                            const SizedBox(height: 10),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.notificationsList.length,
                              itemBuilder: (context,index){
                                return NotificationTile(notificationModel:  controller.notificationsList[index]);
                              },
                            ),
                          ],
                        ),
                      ),
                      onRefresh: () async {
                        controller.init();
                      }):currentState==CurrentState.error? Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText('Error'),
                      ElevatedButton(onPressed: (){
                        controller.init();
                      }, child: const CustomText('Try again'))
                    ],
                  ),):const SizedBox();
                }









            ),
          )





    );
  }
}
