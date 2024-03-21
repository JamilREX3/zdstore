import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zdstore/constants/k_constants.dart';
import 'package:zdstore/controllers/bank_controller.dart';
import 'package:zdstore/utils/enum_state.dart';
import 'package:zdstore/views/add_credit_view.dart';
import '../components/custom_text.dart';

class BankView extends StatelessWidget {
  const BankView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BankController());
    return GetBuilder<BankController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                forceMaterialTransparency: true,
                centerTitle: true,
                title: const CustomText('Banks'),
              ),
              body: Obx(() {
                CurrentState currentState = controller.currentState.value;
                return currentState == CurrentState.loading
                    ? const Center(child: CircularProgressIndicator())
                    : currentState == CurrentState.full
                        ? ListView.builder(
                            itemCount: controller.banksList.length,
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            itemBuilder: (context, index) {
                              if (controller.banksList[index].visible == 1) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(AddCreditView(
                                            bankModel:
                                                controller.banksList[index],
                                            currenciesList:
                                                controller.currenciesList));
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: KConstants.imageBaseUrl +
                                              controller.banksList[index].img
                                                  .toString(),
                                          errorWidget: (err, str, ob) {
                                            return Container(
                                                color: Colors.deepPurple,
                                                padding:
                                                    const EdgeInsets.all(30),
                                                child: CustomText(controller
                                                    .banksList[index].name
                                                    .toString()));
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
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
