import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zdstore/models/order_details_model.dart';

import '../../components/custom_text.dart';

class OrderDetailsReplays extends StatelessWidget {
  final OrderDetailsModel orderDetailsModel;

  const OrderDetailsReplays({super.key, required this.orderDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            CustomText(
              'Replays',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        ...orderDetailsModel.replay!
            .map(
              (e) => InkWell(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: e.replay![0]));
                  Get.showSnackbar(
                    GetSnackBar(
                      message: 'Copied to clipboard'.tr,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: CustomText(
                        e.replay![0],
                        //style: const TextStyle(color: Colors.white),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      )),
                      const Icon(
                        Icons.copy,
                        color: Colors.white,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
