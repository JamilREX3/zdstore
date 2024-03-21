import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zdstore/components/customTextField.dart';
import 'package:zdstore/components/custom_text.dart';
import 'package:zdstore/controllers/global_search_controller.dart';
import 'package:zdstore/utils/enum_state.dart';
import 'package:zdstore/views/make_order_view.dart';
import 'package:zdstore/views/order_details_view/order_details_view.dart';

class GlobalSearchView extends StatelessWidget {
  const GlobalSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GlobalSearchController());
    return GetBuilder<GlobalSearchController>(
      builder: (controller) => Scaffold(
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextFormField(
                controller: controller.searchTextEditingController,
                //textDirection: isArabic(controller.searchTextEditingController.text) ? TextDirection.rtl : TextDirection.ltr,
                onTap: () {
                  controller.searchTextEditingController.selection =
                      TextSelection.collapsed(
                          offset: controller
                              .searchTextEditingController.text.length);
                },
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    controller.getResult(value);
                  }
                },
                suffixIconNull: Icons.search_rounded,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
            Obx(() => controller.currentState.value == CurrentState.full
                ? DefaultTabController(
                    length: controller.globalSearchController.searchOrdersList!
                                .isNotEmpty &&
                            controller.globalSearchController
                                .searchProductsList!.isNotEmpty
                        ? 2
                        : 1,
                    child: Expanded(
                      child: Column(
                        children: [
                          TabBar(
                            tabs: [
                              if (controller.globalSearchController
                                  .searchProductsList!.isNotEmpty)
                                Tab(text: 'Products'.tr),
                              if (controller.globalSearchController
                                  .searchOrdersList!.isNotEmpty)
                                Tab(text: 'Orders'.tr),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                if (controller.globalSearchController
                                        .searchProductsList?.isNotEmpty ==
                                    true)
                                  SingleChildScrollView(
                                      child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () {
                                          Get.to(MakeOrderView(
                                            productId: controller
                                                .globalSearchController
                                                .searchProductsList![index]
                                                .id
                                                .toString(),
                                          ));
                                        },
                                        title: CustomText(controller
                                            .globalSearchController
                                            .searchProductsList![index]
                                            .name
                                            .toString()),
                                      );
                                    },
                                    itemCount: controller.globalSearchController
                                        .searchProductsList!.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                  )),
                                if (controller.globalSearchController
                                        .searchOrdersList?.isNotEmpty ==
                                    true)
                                  SingleChildScrollView(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.to(OrderDetailsView(
                                                orderId: controller
                                                    .globalSearchController
                                                    .searchOrdersList![index]
                                                    .id
                                                    .toString()));
                                          },
                                          child: ListTile(
                                            title: CustomText(controller
                                                .globalSearchController
                                                .searchOrdersList![index]
                                                .productName
                                                .toString()),
                                            trailing: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: controller
                                                              .globalSearchController
                                                              .searchOrdersList![
                                                                  index]
                                                              .accept ==
                                                          0
                                                      ? Colors.orangeAccent
                                                      : controller
                                                                  .globalSearchController
                                                                  .searchOrdersList![
                                                                      index]
                                                                  .accept ==
                                                              1
                                                          ? Colors.green
                                                          : Colors.red),
                                              child: Icon(
                                                controller
                                                            .globalSearchController
                                                            .searchOrdersList![
                                                                index]
                                                            .accept ==
                                                        0
                                                    ? Icons.access_time
                                                    : controller
                                                                .globalSearchController
                                                                .searchOrdersList![
                                                                    index]
                                                                .accept ==
                                                            1
                                                        ? Icons.done
                                                        : Icons.remove,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            subtitle: CustomText(
                                              DateFormat('dd/M/yyyy h:mm a')
                                                  .format(controller
                                                      .globalSearchController
                                                      .searchOrdersList![index]
                                                      .createdAt!),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: controller
                                          .globalSearchController
                                          .searchOrdersList!
                                          .length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : controller.currentState.value == CurrentState.loading
                    ? Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.3,
                          ),
                          const CircularProgressIndicator()
                        ],
                      )
                    : controller.currentState.value == CurrentState.empty
                        ? Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.3,
                              ),
                              const CustomText('Empty')
                            ],
                          )
                        : const SizedBox()),
          ],
        ),
      ),
    );
  }
}
