import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zdstore/controllers/global_controller.dart';
import 'package:zdstore/controllers/transactions_controller.dart';
import 'package:zdstore/utils/enum_state.dart';
import 'package:zdstore/views/transactions_view/transaction_tile.dart';
import '../../components/custom_text.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Get.put(TransactionsController());
    return GetBuilder<TransactionsController>(
      builder: (controller) => Obx(() {

        CurrentState currentState = controller.currentState.value;
        return currentState == CurrentState.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            :currentState==CurrentState.full? RefreshIndicator(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 6),
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
                              controller.getTransactions(
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
                      SizedBox(
                        height: Get.height * 0.1,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const SizedBox(width: 6),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: isDarkMode == true
                                        ? [
                                            const Color(0xff00A759),
                                            const Color(0xff008493)
                                          ]
                                        : [
                                            const Color(0xff47E49B),
                                            const Color(0xff5ADEEC)
                                          ],
                                  )),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CustomText('Balance'),
                                  const SizedBox(height: 10),
                                  CustomText(
                                    NumberFormat('#,##0.00').format(
                                        double.parse(
                                            Get.find<GlobalController>()
                                                .userModel
                                                .value
                                                .balance!)),
                                    style: const TextStyle(
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: isDarkMode == true
                                        ? [
                                            const Color(0xffD66011),
                                            const Color(0xffBF0020)
                                          ]
                                        : [
                                            const Color(0xffE2714F),
                                            const Color(0xffE4586F)
                                          ],
                                  )),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CustomText('Total Purchases'),
                                  const SizedBox(height: 10),
                                  CustomText(
                                    NumberFormat('#,##0.00').format(
                                        double.parse(controller
                                            .tranActionsFullModel.totalPurchases
                                            .toString())),
                                    style: const TextStyle(
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),

                            //todo when refresh update the my balance because it come from globalController
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: isDarkMode == true
                                        ? [
                                            const Color(0xff143E7A),
                                            const Color(0xff471069)
                                          ]
                                        : [
                                            const Color(0xff75A4E6),
                                            const Color(0xff9481E1)
                                          ],
                                  )),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CustomText('Received'),
                                  const SizedBox(height: 10),
                                  CustomText(
                                    NumberFormat('#,##0.00').format(
                                        double.parse(controller
                                            .tranActionsFullModel.receive
                                            .toString())),
                                    style: const TextStyle(
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19),
                                  )
                                ],
                              ),
                            ),
                            //todo add debit balance

                            const SizedBox(width: 6),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller
                            .tranActionsFullModel.transactions!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TransactionsTail(
                              transaction: controller
                                  .tranActionsFullModel.transactions![index]);
                        },
                      ),
                    ],
                  ),
                ),
                onRefresh: () async {
                  controller.init();
                },
              ):currentState==CurrentState.error?Center(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText('Error'),
            ElevatedButton(onPressed: (){
                controller.init();
            }, child: const CustomText('Try again'))
          ],
        ),
              ):const SizedBox();
      }),
    );
  }
}
