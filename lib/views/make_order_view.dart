import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:zdstore/components/customTextField.dart';
import 'package:zdstore/components/custom_text.dart';
import 'package:zdstore/controllers/make_order_controller.dart';
import 'package:zdstore/models/home_content_model.dart';
import 'package:zdstore/utils/enum_state.dart';


class MakeOrderView extends StatelessWidget {
  final ProductModel? product;
  final String? productId;

  const MakeOrderView({super.key, this.product , this.productId});

  @override
  Widget build(BuildContext context) {


    if(product!=null){
      Get.put(MakeOrderController(product: product));
    }else{
      Get.put(MakeOrderController(productId: productId));
    }




    return GetBuilder<MakeOrderController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.transparent,
          forceMaterialTransparency: true,
          centerTitle: true,
          title: const CustomText('Checkout'),
        ),
        body:Obx(()=>controller.currentState.value==CurrentState.loading?const Center(child: CircularProgressIndicator()):controller.currentState.value==CurrentState.full? SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomText(
                      controller.product!.productName.toString(),
                      style: const TextStyle(fontSize: 24),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
                ],
              ),
              const SizedBox(height: 20),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.textFieldRequires.length,
                itemBuilder: (context, index) {
                  return CustomTextFormField(
                    controller:
                    controller.requiresTextEditingControllersList[index],
                    labelText: controller.textFieldRequires[index].name,
                    hintText: controller.textFieldRequires[index].question,
                  );
                },
              ),
              ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.dropDownRequires.length,
                itemBuilder: (context, index) {
                  return DropdownButtonFormField<dynamic>(
                    focusColor: Colors.transparent,
                    focusNode: FocusNode(
                        skipTraversal: true,
                        canRequestFocus: false,
                        descendantsAreFocusable: false,
                        descendantsAreTraversable: false),
                    isExpanded: true,
                    hint: CustomText(
                        controller.dropDownRequires[index].question.toString()),
                    isDense: false,
                    //value: controller.dropDownSelectedValues[index],
                    padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    decoration: InputDecoration(
                      focusColor: Colors.transparent,
                      //  labelText: widget.labelText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                        ),
                      ),
                      //filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 16, 16, 0),
                      fillColor: Colors.white24,
                    ),
                    onChanged: (newValue) {
                      print(newValue);
                      print('index = $index');
                      controller.dropDownSelectedValues[index] =
                          newValue.toString();
                      print(
                          'selectedList = ${controller.dropDownSelectedValues[index]}');
                      // controller.selectedCountryModel = Rx<CountryModel>(newValue!);
                      // controller.update();
                    },
                    items: controller.dropDownRequires[index].typeValue
                        .map<DropdownMenuItem<dynamic>>((e) {
                      print('e = $e');
                      return DropdownMenuItem<dynamic>(
                        value: e,
                        child: CustomText(
                          e,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.amountsRequires.length,
                itemBuilder: (context, index) {
                  return Obx(() => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          keyboardType: TextInputType.number,
                          controller: controller
                              .amountsTextEditingControllers[index],
                          labelText: controller.amountsRequires[index].name,
                          hintText:
                          controller.amountsRequires[index].question,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          errorText:
                          controller.amountErrorText.value.isEmpty
                              ? null
                              : controller.amountErrorText.value,
                          onChanged: (amount) {
                            controller.calcTotalPrice(
                                amount,
                                num.parse(controller.amountsRequires[index]
                                    .typeValue['min']),
                                num.parse(controller.amountsRequires[index]
                                    .typeValue['max'].toString()));
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextFormField(
                          labelText: 'Total',
                          //initialValue:  controller.calcTotalPrice(controller.amountsTextEditingControllers[index].text, num.parse(controller.amountsRequires[index].typeValue['min']), num.parse(controller.amountsRequires[index].typeValue['max'])).value,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          enabled: false,
                          controller: controller.totalPrice,

                          //initialValue: controller.totalPrice.value,
                        ),
                      ),
                    ],
                  ));
                },
              ),
              ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.quantityRequires.length,
                itemBuilder: (context, index) {
                  return Obx(() => Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                controller
                                    .quantityTextEditingControllers[index]
                                    .text = (int.parse(controller
                                    .quantityTextEditingControllers[
                                index]
                                    .text) +
                                    1)
                                    .toString();
                                controller.calcTotalPrice(
                                  controller
                                      .quantityTextEditingControllers[index]
                                      .text,
                                  num.parse(controller
                                      .quantityRequires[index]
                                      .typeValue['min']
                                      .toString()),
                                  num.parse(
                                    controller.quantityRequires[index]
                                        .typeValue['max'],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add)),
                          SizedBox(
                            width: Get.width * 0.5,
                            child: CustomTextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              controller: controller
                                  .quantityTextEditingControllers[index],
                              labelText:
                              controller.quantityRequires[index].name,
                              hintText: controller
                                  .quantityRequires[index].question,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              errorText:
                              controller.amountErrorText.value.isEmpty
                                  ? null
                                  : controller.amountErrorText.value,
                              onChanged: (amount) {
                                controller.calcTotalPrice(
                                  amount,
                                  num.parse(controller
                                      .quantityRequires[index]
                                      .typeValue['min']
                                      .toString()),
                                  num.parse(
                                    controller.quantityRequires[index]
                                        .typeValue['max'],
                                  ),
                                );
                              },
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                controller
                                    .quantityTextEditingControllers[index]
                                    .text = (int.parse(controller
                                    .quantityTextEditingControllers[
                                index]
                                    .text) -
                                    1)
                                    .toString();
                                controller.calcTotalPrice(
                                  controller
                                      .quantityTextEditingControllers[index]
                                      .text,
                                  num.parse(controller
                                      .quantityRequires[index]
                                      .typeValue['min']
                                      .toString()),
                                  num.parse(
                                    controller.quantityRequires[index]
                                        .typeValue['max'],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.remove)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      CustomTextFormField(
                        labelText: 'Total',
                        //initialValue:  controller.calcTotalPrice(controller.amountsTextEditingControllers[index].text, num.parse(controller.amountsRequires[index].typeValue['min']), num.parse(controller.amountsRequires[index].typeValue['max'])).value,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        enabled: false,
                        controller: controller.totalPrice,

                        //initialValue: controller.totalPrice.value,
                      ),
                    ],
                  ));
                },
              ),

              //otp
              controller.otpEnabled == true
                  ? CustomTextFormField(
                controller: controller.otpTextController,
                labelText: 'OTP',
                hintText: 'OTP',
              )
                  : const SizedBox(),

              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     ElevatedButton(onPressed: (){
              //       controller.submit();
              //     }, child: CustomText('Submit'),)
              //   ],
              // )
              // RoundedLoadingButton(
              //   controller: controller.roundedLoadingButtonController,
              //   color: Get.theme.elevatedButtonTheme.style!.backgroundColor!.resolve()),
              //   onPressed: () {
              //     controller.fakeSubmit();
              //   },
              //   child: Text('Fake submit'),
              // )
              const SizedBox(height: 20),
              RoundedLoadingButton(
                controller: controller.roundedLoadingButtonController,
                animateOnTap: false,
                //color: Colors.red,
                // curve:  Curves.easeInSine,
                //completionCurve: Curves.linearToEaseOut,
                color: Theme.of(context).elevatedButtonTheme.style?.backgroundColor!.resolve({}),
                valueColor:Theme.of(context).primaryColor,
                onPressed: () {
                  controller.submit();
                },
                child: const Text('Fake submit'),
              )
            ],
          ),
        ):const Center(child: CustomText('This product is not available now'),)),
      ),
    );
  }
}
