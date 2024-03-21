import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zdstore/components/customTextField.dart';
import 'package:zdstore/components/custom_text.dart';
import 'package:zdstore/controllers/set_info_controller.dart';
import 'package:zdstore/models/country_model.dart';
import 'package:zdstore/utils/enum_state.dart';

class SetInfoView extends StatelessWidget {
  const SetInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SetInfoController());
    return GetBuilder<SetInfoController>(
      builder: (controller) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
        body: Obx(
          () => controller.currentState.value == CurrentState.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    children: [
                      SizedBox(height: Get.height * 0.1),
                      const Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              'Please complete the registration process',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              maxLines: 2, // You can change it accordingly
                              overflow: TextOverflow.ellipsis, //
                              // And this
                            ),
                          ),


                        ],
                      ),
                      SizedBox(height: Get.height * 0.05),
                      Row(
                        children: [
                          Expanded(
                            child: Theme(
                              data: Theme.of(context).copyWith(     // <- Here
                                splashColor: Colors.transparent,    // <- Here
                                highlightColor: Colors.transparent, // <- Here
                                hoverColor: Colors.transparent),
                                child: DropdownButtonFormField<CountryModel>(
                                focusColor: Colors.transparent,
                                focusNode: FocusNode( skipTraversal: true,canRequestFocus: false,descendantsAreFocusable: false,descendantsAreTraversable: false),
                                isExpanded: true,
                                hint: const CustomText('Country'),
                                isDense: false,
                                value: controller.selectedCountryModel?.value,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
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
                                  contentPadding:  const EdgeInsets.fromLTRB(10, 16, 16, 0),
                                  fillColor: Colors.white24,
                                ),
                                onChanged: (CountryModel? newValue){
                                  controller.selectedCountryModel = Rx<CountryModel>(newValue!);
                                  controller.update();
                                },
                                items: controller.countriesList!
                                    .map<DropdownMenuItem<CountryModel>>(
                                      (CountryModel e) =>
                                      DropdownMenuItem<CountryModel>(
                                        value: e,
                                        child: CustomText(e.name!,),
                                      ),
                                )
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.02),
                      controller.selectedCountryModel!=null?Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                         // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText('+${controller.selectedCountryModel!.value.callingCode}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomTextFormField(
                                keyboardType: TextInputType.number,
                                hintText: 'Phone',
                                suffixIconNull: Icons.phone,
                                controller: controller.phoneController,
                                labelText: 'Phone',
                              ),
                            ),
                          ],
                        ),
                      ):const SizedBox(),


                      SizedBox(height: Get.height * 0.02),
                      CustomTextFormField(
                        controller: controller.agentController,
                        labelText: '${'Agent'.tr} (${'Optional'.tr})',

                      ),

                      ElevatedButton(onPressed: (){
                        controller.submitInfo();
                      }, child: const CustomText('Submit')),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
