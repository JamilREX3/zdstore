import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:zdstore/components/customTextField.dart';
import 'package:zdstore/controllers/add_credit_controller.dart';
import 'package:zdstore/models/bank_model.dart';
import '../components/custom_text.dart';
import '../models/currency_model.dart';

class AddCreditView extends StatelessWidget {
  final BankModel bankModel;
  final List<CurrencyModel> currenciesList;

  const AddCreditView(
      {super.key, required this.bankModel, required this.currenciesList});

  @override
  Widget build(BuildContext context) {
    Get.put(AddCreditController(
        bankModel: bankModel, currenciesList: currenciesList));
    return GetBuilder<AddCreditController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          title: CustomText(bankModel.name.toString()),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.infoList.length,
                itemBuilder: (context, index) {
                  String temp = controller.infoList[index];
                  if (temp.contains('#')) {
                    temp = temp.substring(1);
                    return InkWell(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: temp));
                        Get.showSnackbar(
                          GetSnackBar(
                            message: 'Copied to clipboard'.tr,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: Row(
                            children: [
                              Expanded(
                                  child: CustomText(temp,
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis)),
                              const Icon(Icons.copy_rounded)
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Text(temp);
                  }
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 4);
                },
              ),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.fullRequiresForms.length,
                itemBuilder: (context, index) {
                  return CustomTextFormField(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    controller: controller
                        .fullRequiresForms[index].textEditingController,
                    maxLines:
                        controller.fullRequiresForms[index].bankRequire.type ==
                                'textarea'
                            ? 5
                            : 1,
                    hintText: Get.locale?.languageCode == 'ar'
                        ? controller
                            .fullRequiresForms[index].bankRequire.names!['ar']
                        : controller
                            .fullRequiresForms[index].bankRequire.names?['en'],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 4);
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 12,
                    child: CustomTextFormField(
                      keyboardType: TextInputType.number,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      controller: controller.creditValue,
                      hintText: 'Value',
                      onChanged: (value) {
                        controller.calcTax();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          // <- Here
                          splashColor: Colors.transparent, // <- Here
                          highlightColor: Colors.transparent, // <- Here
                          hoverColor: Colors.transparent),
                      child: DropdownButtonFormField<CurrencyModel>(
                        focusColor: Colors.transparent,
                        focusNode: FocusNode(
                            skipTraversal: true,
                            canRequestFocus: false,
                            descendantsAreFocusable: false,
                            descendantsAreTraversable: false),
                        isExpanded: true,
                        hint: const CustomText('Currency'),
                        isDense: true,
                        value: controller.selectedCurrencyModel?.value,
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 0),
                        decoration: InputDecoration(
                          focusColor: Colors.transparent,
                          //  labelText: widget.labelText,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              style: BorderStyle.solid,
                            ),
                          ),
                          //filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 16, 16, 0),
                          fillColor: Colors.white24,
                        ),
                        onChanged: (CurrencyModel? newValue) {
                          controller.selectedCurrencyModel =
                              Rx<CurrencyModel>(newValue!);
                          controller.calcTax();
                          controller.update();
                        },
                        items: controller.currenciesList
                            .map<DropdownMenuItem<CurrencyModel>>(
                              (CurrencyModel e) =>
                                  DropdownMenuItem<CurrencyModel>(
                                value: e,
                                child: CustomText(
                                  e.code!,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                labelText: 'The value to be sent',
                controller: controller.valueAfterTax,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                enabled: false,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const CustomText('Payment notice'),
                  const CustomText(' (',style: TextStyle(fontSize: 12,color: Colors.grey)),
                  const CustomText('Optional',style: TextStyle(fontSize: 12,color: Colors.grey)),
                  const CustomText(')',style: TextStyle(fontSize: 12,color: Colors.grey)),
                  const CustomText('  :'),
                  const Expanded(child: SizedBox()),
                  controller.pickedImage == null
                      ? ElevatedButton(
                          onPressed: () {
                            controller.pickImage();
                          },
                          child: const CustomText('Browse'))
                      : Stack(
                          children: [
                            Image.file(
                              File(controller.pickedImage!.path),
                              width: Get.width * 0.5,
                            ),
                            IconButton(
                              onPressed: () {
                                controller.pickedImage = null;
                                controller.update();
                              },
                              icon: const Icon(
                                Icons.cancel,
                              ),
                            )
                          ],
                        )
                ],
              ),
              const SizedBox(height: 50),
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
                child: const Text('Order'),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
