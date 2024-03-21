import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:zdstore/constants/k_constants.dart';
import 'package:zdstore/controllers/profile_controller.dart';
import 'package:zdstore/utils/enum_state.dart';
import 'package:zdstore/views/group_view.dart';

import '../components/customTextField.dart';
import '../components/custom_text.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return GetBuilder<ProfileController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          title: const CustomText('Profile'),
        ),
        body: Obx(
          () => controller.currentState.value == CurrentState.loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 2),
                        margin: Get.locale?.languageCode == 'ar'
                            ? const EdgeInsets.only(right: 12)
                            : const EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? Colors.deepPurple
                              : Colors.deepPurpleAccent.shade100,
                          borderRadius: Get.locale?.languageCode == 'ar'
                              ? const BorderRadius.only(
                                  topRight: Radius.circular(45),
                                  bottomRight: Radius.circular(45),
                                )
                              : const BorderRadius.only(
                                  topLeft: Radius.circular(45),
                                  bottomLeft: Radius.circular(45),
                                ),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              child: CircleAvatar(
                                backgroundImage: controller.pickedImage==null?CachedNetworkImageProvider(
                                    controller.userModel.avatar ??
                                        'https://www.w3schools.com/howto/img_avatar.png'):FileImage(File(controller.pickedImage!.path)) as ImageProvider,
                                minRadius: 45,
                                maxRadius: 45,
                              ),
                              onTap: (){
                                controller.pickImage();
                              },
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.6,
                                  child: Row(
                                    children: [
                                      const CustomText('Balance'),
                                      const CustomText(' : '),
                                      Expanded(
                                          child: CustomText(
                                        NumberFormat('#,##0.00').format(
                                            double.parse(controller
                                                .userModel.balance
                                                .toString())),
                                        maxLines: 6,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 19),
                                      ))
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    const CustomText('Currency'),
                                    const CustomText(' : '),
                                    CustomText(
                                      controller.userModel.currencyCode
                                          .toString(),
                                      style: const TextStyle(
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 19),
                                    )
                                  ],
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Get.to(const GroupView());
                                  },
                                  child: Row(
                                    children: [
                                      const CustomText('Level'),
                                      const CustomText(' : '),
                                      CustomText(
                                        controller.userModel.groupName.toString(),
                                        style: const TextStyle(
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 19),
                                      ),
                                      controller.userModel.groupLogo!.contains('svg')==true?SvgPicture.network('${KConstants.imageBaseUrl}/${controller.userModel.groupLogo}',height: 40,width: 40):Image.network('${KConstants.imageBaseUrl}/${controller.userModel.groupLogo}' ,height: 40,width: 40,),
                                      // SvgPicture.asset(
                                      //     'assets/svg/bronze-medal.svg'),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 56),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [

                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 14,horizontal: 16),
                                    hintText: 'firstname',
                                    // prefixIcon: Icons.person,
                                    controller: controller.firstNameController,
                                    labelText: 'firstname',
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: CustomTextFormField(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 14,horizontal: 16),
                                    hintText: 'lastname',
                                    //prefixIcon: Icons.phone,
                                    // keyboardType:
                                    // const TextInputType.numberWithOptions(decimal: true),
                                    controller: controller.lastNameController,
                                    labelText: 'lastname',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Stack(
                              children: [
                                controller.userModel.emailActive!=null && controller.userModel.emailActive!=false?Positioned(
                                  left: 10,
                                  top: 14,
                                  child: Icon(
                                    Icons.verified,
                                    color: Colors.grey.shade700,
                                  ),
                                ):const SizedBox(),
                                CustomTextFormField(
                                  labelText: 'Email',
                                  initialValue: controller.userModel.email,
                                  // controller: controller.valueAfterTax,
                                  contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                  enabled: false,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            CustomTextFormField(
                              labelText: 'username',
                              initialValue: controller.userModel.username,
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              enabled: false,
                            ),
                            const SizedBox(height: 16.0),
                            CustomTextFormField(
                              labelText: 'Phone',
                              initialValue: controller.userModel.phone,
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              enabled: false,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height*0.15),
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
                        child: const CustomText('Submit'),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
