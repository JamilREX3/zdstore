import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zdstore/components/customTextField.dart';
import 'package:zdstore/components/custom_text.dart';
import 'package:zdstore/components/my_alert_dialog.dart';
import 'package:zdstore/controllers/order_details_controller.dart';
import 'package:zdstore/utils/enum_state.dart';
import 'package:zdstore/views/order_details_view/order_details_objections.dart';
import 'package:zdstore/views/order_details_view/order_details_replays.dart';

class OrderDetailsView extends StatelessWidget {
  final String orderId;
  const OrderDetailsView({super.key, required this.orderId});
  @override
  Widget build(BuildContext context) {
    Get.put(OrderDetailsController(orderId: orderId));
    return GetBuilder<OrderDetailsController>(
      builder: (controller) => Scaffold(
        body: Obx(
          () => controller.currentState.value == CurrentState.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            //appBar
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                    controller.orderDetailsModel.productName ??
                                        '',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center),
                              ],
                            ),
                            const SizedBox(height: 30),
                            //table
                            controller.orderDetailsModel.data!.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 16, top: 10),
                                    child: Table(
                                      border: TableBorder.all(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.shade400,
                                          width: 1.5),
                                      children: [
                                        const TableRow(children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6),
                                            child: CustomText(
                                              'Requirement',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6),
                                            child: CustomText(
                                              'Value',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ]),
                                        ...controller
                                            .orderDetailsModel.data!.entries
                                            .map(
                                              (e) => TableRow(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 6),
                                                    child: CustomText(e.key,
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      await Clipboard.setData(
                                                          ClipboardData(
                                                              text: controller
                                                                  .orderDetailsModel
                                                                  .id
                                                                  .toString()));
                                                      Get.showSnackbar(
                                                        GetSnackBar(
                                                          message:
                                                              'Copied to clipboard'
                                                                  .tr,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 2),
                                                        ),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 6),
                                                      child: RichText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 3,
                                                        text: TextSpan(
                                                          children: <InlineSpan>[
                                                            TextSpan(
                                                                text:
                                                                    '${e.value}  ',
                                                                style: context
                                                                    .theme
                                                                    .textTheme
                                                                    .bodyMedium),
                                                            const WidgetSpan(
                                                              child: Icon(
                                                                Icons.copy,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                            .toList(),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),

                            // orderId
                            InkWell(
                              onTap: () async {
                                await Clipboard.setData(ClipboardData(
                                    text: controller.orderDetailsModel.id
                                        .toString()));
                                Get.showSnackbar(
                                  GetSnackBar(
                                    message: 'Copied to clipboard'.tr,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.indigoAccent.shade700,
                                      Colors.indigoAccent.shade100
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const CustomText(
                                      'Order id',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    RichText(
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      text: TextSpan(
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text:
                                                '${controller.orderDetailsModel.id.toString()}  ',
                                          ),
                                          const WidgetSpan(
                                            child: Icon(
                                              Icons.copy,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // quantity and price
                            Row(
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3, vertical: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.indigoAccent.shade700,
                                          Colors.indigoAccent.shade100
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const CustomText(
                                          'Quantity',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        CustomText(
                                          controller.orderDetailsModel.quantity
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 20,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3, vertical: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.indigoAccent.shade700,
                                          Colors.indigoAccent.shade100
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const CustomText(
                                          'Price',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        CustomText(
                                          '${num.parse(controller.orderDetailsModel.price.toString()).toStringAsFixed(3)}  ${controller.orderDetailsModel.currencyCode}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //order status
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: controller.orderDetailsModel.accept ==
                                          0
                                      ? [
                                          Colors.orangeAccent.shade700,
                                          Colors.orangeAccent.shade100
                                        ]
                                      : controller.orderDetailsModel.accept == 1
                                          ? [
                                              Colors.green.shade700,
                                              Colors.green.shade200
                                            ]
                                          : [
                                              Colors.redAccent.shade700,
                                              Colors.redAccent.shade100
                                            ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const CustomText(
                                    'Order status',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  CustomText(
                                    controller.orderDetailsModel.cancel == 1
                                        ? 'Canceled'
                                        : controller.orderDetailsModel.accept ==
                                                0
                                            ? 'Pending'
                                            : controller.orderDetailsModel
                                                        .accept ==
                                                    1
                                                ? 'Accepted'
                                                : 'Rejected',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            // created at
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.indigoAccent.shade700,
                                    Colors.indigoAccent.shade100
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const CustomText(
                                    'Order date',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  CustomText(
                                    DateFormat('dd/M/yyyy h:mm a').format(
                                        controller
                                            .orderDetailsModel.createdAt!),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            //updated at
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.indigoAccent.shade700,
                                    Colors.indigoAccent.shade100
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const CustomText(
                                    'Update date',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  CustomText(
                                    controller.orderDetailsModel.updatedAt
                                        .toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            controller.orderDetailsModel.diff != null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.access_time_rounded,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 5),
                                      CustomText(
                                        '${'Response time'.tr} :   ${controller.orderDetailsModel.diff.toString()}',
                                      ),
                                    ],
                                  )
                                : const SizedBox(),

                            controller.orderDetailsModel.replay?.isNotEmpty ==
                                    true
                                ? const Divider()
                                : const SizedBox(),
                            controller.orderDetailsModel.replay?.isNotEmpty ==
                                    true
                                ? OrderDetailsReplays(
                                    orderDetailsModel:
                                        controller.orderDetailsModel)
                                : const SizedBox(),
                            controller.orderDetailsModel.objection
                                        ?.isNotEmpty ==
                                    true
                                ? const Divider()
                                : const SizedBox(),
                            controller.orderDetailsModel.objection
                                        ?.isNotEmpty ==
                                    true
                                ? OrderDetailsObjections(
                                    orderDetailsModel:
                                        controller.orderDetailsModel)
                                : const SizedBox(),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 6,
                        child: Container(
                                width: Get.width,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Row(
                                  children: [
                                    controller.orderDetailsModel
                                                .allowObjection ==
                                            true
                                        ? Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                controller
                                                        .objectionTextEditingController =
                                                    TextEditingController();
                                                controller.objectionPressed
                                                    .value = true;

                                                // Get.bottomSheet(
                                                //   Container(
                                                //     color: Colors.red,
                                                //     height: 200,
                                                //   ),
                                                // );




                                                Get.dialog(Center(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).colorScheme.background,
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                                                    margin: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.width*0.7),
                                                    // width: 50,height: 100,
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          CustomTextFormField(
                                                            controller: controller.objectionTextEditingController,
                                                            minLines: 2,
                                                            maxLines: 5,
                                                            labelText: 'Objection',
                                                          ),
                                                          InkWell(
                                                            onTap: (){
                                                              controller.makeObjection();
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.circular(10),
                                                                color: Colors.indigoAccent.shade200,
                                                              ),
                                                              padding: const EdgeInsets.symmetric(
                                                                  vertical: 10,horizontal: 50),
                                                              child: const CustomText('Send',
                                                                  style:
                                                                  TextStyle(color: Colors.white),
                                                                  textAlign: TextAlign.center),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors
                                                      .indigoAccent.shade200,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16),
                                                child: const CustomText(
                                                    'Objection',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    controller.orderDetailsModel.accept == 0 &&
                                            controller.orderDetailsModel
                                                    .canCancel! <
                                                0
                                        ? const SizedBox(width: 6)
                                        : const SizedBox(),
                                    controller.orderDetailsModel.accept == 0 &&
                                            controller.orderDetailsModel
                                                    .canCancel! <
                                                0
                                        ? Expanded(
                                            child: InkWell(
                                              onTap: (){
                                                Get.dialog(MyAlertDialog(title: 'Alert',cancelString: 'No',confirmString: 'Yes, sure!', content: 'Are you want to cancel this order?', onDelete: (){
                                                 controller.cancelOrder();
                                                }));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16),
                                                child: const CustomText(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
