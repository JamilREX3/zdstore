import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zdstore/components/customTextField.dart';
import 'package:zdstore/components/custom_text.dart';
import 'package:zdstore/controllers/orders_log_controller.dart';
import 'package:zdstore/utils/enum_state.dart';
import 'package:zdstore/views/orders_view/orders_tile.dart';

class OrdersLogView extends StatelessWidget {
  const OrdersLogView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersLogController());
    return GetBuilder<OrdersLogController>(
      initState: (_) {
        Get.find<OrdersLogController>().init();
      },
      builder: (controller) => Obx(

        () {
          CurrentState currentState = controller.currentState.value;
            return controller.currentState.value == CurrentState.loading
            ? const Center(child: CircularProgressIndicator())
            :currentState==CurrentState.full? RefreshIndicator(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 6),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                width: Get.width * 0.65,
                                child: CustomTextFormField(
                                  //controller: controller.searchTextController,
                                  hintText: 'search by order number',
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  onFieldSubmitted: (orderNumberValue) {
                                    if (orderNumberValue.isNotEmpty) {
                                      controller.searchOrderByNumber(
                                          orderNumberValue);
                                    } else {
                                      controller.getOrdersLog();
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
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
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        10, 16, 16, 0),
                                    fillColor: Colors.white24,
                                  ),
                                  focusColor: Colors.transparent,
                                  focusNode: FocusNode(
                                      skipTraversal: true,
                                      canRequestFocus: false,
                                      descendantsAreFocusable: false,
                                      descendantsAreTraversable: false),
                                  isExpanded: true,
                                  value: controller.dateFilterMap.keys
                                      .firstWhere(
                                          (key) =>
                                              key ==
                                              controller.selectedTimeKeyFilter,
                                          orElse: () => controller
                                              .dateFilterMap.keys.first),
                                  icon: const Icon(
                                      Icons.arrow_drop_down_outlined),
                                  onChanged: (dynamic newValue) {
                                    controller.getOrdersLog(
                                        startTimeFilterParam: newValue);
                                  },
                                  items: controller.dateFilterMap.keys
                                      .toList()
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: CustomText(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.ordersList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return OrdersTile(
                              orderModel: controller.ordersList[index]);
                        },
                      ),
                    ],
                  ),
                ),
                onRefresh: () async {
                  controller.init();
                },
              ):currentState==CurrentState.error?Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const CustomText('Error'),
                  ElevatedButton(onPressed: (){
                    controller.init();
                  }, child: const CustomText('Try again'))
                ],
              ),
            ):const SizedBox();


  }
      ),
    );
  }
}
