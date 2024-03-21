import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zdstore/components/custom_text.dart';
import 'package:zdstore/models/notifications_model.dart';
import 'package:zdstore/views/order_details_view/order_details_view.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notificationModel;

  const NotificationTile({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Card(
        child: ExpansionTile(
          title: CustomText(notificationModel.title.toString()),
          leading: const Icon(Icons.notifications_rounded),
          onExpansionChanged: (value) {
            print(value);
          },
          subtitle: CustomText(
            notificationModel.diff.toString(),
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          children: [
            Row(
              children: [
                CustomText(notificationModel.detail.toString()),
              ],
            ),
            notificationModel.type=='order'?ElevatedButton(onPressed: (){
              Get.to(OrderDetailsView(orderId: notificationModel.itemId.toString()));
            }, child: const CustomText('See details'),):const SizedBox()
          ],
        ),
      ),
    );
  }
}
