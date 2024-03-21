import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:zdstore/components/custom_text.dart';
import 'package:zdstore/controllers/global_controller.dart';
import 'package:zdstore/models/all_orders_log_model.dart';
import 'package:zdstore/views/order_details_view/order_details_view.dart';

class OrdersTile extends StatelessWidget {
  final OrderModel orderModel;

  const OrdersTile({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Get.to(OrderDetailsView(orderId: orderModel.id.toString(),));
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Column(
            children: [
              // name with status
              Row(
                children: [
                  Expanded(
                      child: CustomText(
                    orderModel.productName.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: orderModel.accept == 0
                                ? Colors.orangeAccent
                                : orderModel.accept == 1
                                    ? Colors.green
                                    : Colors.red),
                        child: Icon(
                          orderModel.accept == 0
                              ? Icons.access_time
                              : orderModel.accept == 1
                                  ? Icons.done
                                  : Icons.remove,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      CustomText(orderModel.accept == 0
                          ? 'Pending'
                          : orderModel.accept == 1
                              ? 'Accepted'
                              : 'Rejected'),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 4),
              // id
              Row(
                children: [
                  CustomText(orderModel.id.toString()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.1),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.withOpacity(0.03),
                      ),
                      child: CustomText(
                          '${orderModel.totalPrice!.toStringAsFixed(3)}  ${Get.find<GlobalController>().userModel.value.currencyCode}')),
                ],
              ),

              Row(
                children: [
                  CustomText(
                    DateFormat('dd/M/yyyy h:mm a').format(orderModel.createdAt!),
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
