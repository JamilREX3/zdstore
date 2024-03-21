import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:pinput/pinput.dart';
import 'package:zdstore/controllers/settings_controller.dart';
import 'package:zdstore/utils/enum_state.dart';
import 'package:zdstore/views/reset_password_dialog.dart';
import '../components/custom_text.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    return GetBuilder<SettingsController>(
      builder: (controller) => Scaffold(
        //backgroundColor: Color(0xfffcf5e5),
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          title: const CustomText('Settings'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText('Dark mode'),
                    SizedBox(
                      height: 40,
                      //width: 20,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Switch(
                            value: context.isDarkMode,
                            onChanged: (value) async {
                              if (value == false) {
                                Get.changeThemeMode(ThemeMode.light);
                                await GetStorage().write('isDarkMode', false);
                              } else {
                                Get.changeThemeMode(ThemeMode.dark);
                                await GetStorage().write('isDarkMode', true);
                              }
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText('Language'),
                    SizedBox(
                      width: Get.width * 0.45,
                      child: DropdownButtonFormField<dynamic>(
                        focusColor: Colors.transparent,
                        focusNode: FocusNode(
                            skipTraversal: true,
                            canRequestFocus: false,
                            descendantsAreFocusable: false,
                            descendantsAreTraversable: false),
                        isExpanded: true,
                        // hint: CustomText('Language'),
                        isDense: true,
                        value: Get.locale?.languageCode ?? 'en',
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 0),
                        decoration: InputDecoration(
                          focusColor: Colors.transparent,
                          //  labelText: widget.labelText,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              style: BorderStyle.solid,
                            ),
                          ),
                          //filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 0, 20, 0),
                          fillColor: Colors.white24,
                        ),
                        onChanged: (newValue) {
                          print(newValue);
                          controller.changeLanguage(newValue);
                        },
                        items: const [
                          DropdownMenuItem(
                            value: 'ar',
                            child: CustomText('العربية'),
                          ),
                          DropdownMenuItem(
                            value: 'en',
                            child: CustomText('English'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.07),
              Obx(
                () => controller.currentState.value == CurrentState.loading
                    ? Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.2,
                          ),
                          const CircularProgressIndicator(),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              NeumorphicTheme(
                                themeMode: context.isDarkMode
                                    ? ThemeMode.dark
                                    : ThemeMode.light, //or dark / system
                                darkTheme: const NeumorphicThemeData(
                                  baseColor: Color(0xff222222),
                                  depth: 6,
                                  intensity: 0.3,
                                ),
                                theme: const NeumorphicThemeData(
                                  baseColor: Color(0xffffffff),
                                  depth: 6,
                                  intensity: 0.6,
                                ),
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                      lightSource:
                                          Get.locale?.languageCode == 'ar'
                                              ? LightSource.left
                                              : LightSource.right,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          Get.locale?.languageCode == 'ar'
                                              ? const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                )
                                              : const BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                )),
                                      border: NeumorphicBorder(
                                        color: Colors.deepPurpleAccent,
                                        width: context.isDarkMode ? 0.2 : 0.8,
                                      )),
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                          'Two-factor authentication'),
                                      const SizedBox(width: 10),
                                      Icon(
                                        Icons.security,
                                        size: 16,
                                        color: context.isDarkMode
                                            ? Colors.white70
                                            : Colors.black54,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            // padding: EdgeInsets.symmetric(
                            //     horizontal: 5, vertical: 10),
                            padding:
                                EdgeInsets.only(left: 5, right: 5, top: 10),
                            child: CustomText(
                              'When activated, a verification code will be sent with each login attempt',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            // padding: const EdgeInsets.symmetric(
                            //     horizontal: 6, vertical: 10),
                            padding: const EdgeInsets.only(
                                left: 6, right: 6, bottom: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 10),
                                SvgPicture.asset(
                                  'assets/svg/google-authenticator.svg',
                                  width: 18,
                                  height: 18,
                                ),
                                const SizedBox(width: 10),
                                const CustomText('Google Authenticator'),
                                const Expanded(child: SizedBox()),
                                Checkbox(
                                    value: controller.googleAuth.value,
                                    onChanged: (newValue) {
                                      // controller.sendCodeToEmail(newValue!);
                                      controller.changeGoogleAuth(newValue!);
                                    }),
                              ],
                            ),
                          ),
                          controller.needOtpAuthWidget.value == true
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: CustomText(
                                    '${'Your private key has been sent to the email'.tr} ${controller.userModel.email}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          controller.needOtpAuthWidget.value == true
                              ? Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Pinput(
                                      defaultPinTheme: PinTheme(
                                        margin: const EdgeInsets.all(0),
                                        width: 48,
                                        height: 48,
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: context.isDarkMode
                                                  ? Colors.grey.shade700
                                                  : Colors.grey.shade300),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      hapticFeedbackType:
                                          HapticFeedbackType.mediumImpact,
                                      onCompleted: (value) {
                                        controller.submitCodeToUpdateProfile(
                                            verificationCode: value);
                                      },
                                      length: 6,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          controller.userModel.provider2fa == 'google' &&
                                  controller.googleAuth.value == true
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        NeumorphicTheme(
                                          themeMode: context.isDarkMode
                                              ? ThemeMode.dark
                                              : ThemeMode
                                                  .light, //or dark / system
                                          darkTheme: const NeumorphicThemeData(
                                            baseColor: Color(0xff222222),
                                            depth: 6,
                                            intensity: 0.3,
                                          ),
                                          theme: const NeumorphicThemeData(
                                            baseColor: Color(0xffffffff),
                                            depth: 6,
                                            intensity: 0.6,
                                          ),
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                                lightSource:
                                                    Get.locale?.languageCode ==
                                                            'ar'
                                                        ? LightSource.left
                                                        : LightSource.right,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(Get.locale
                                                                ?.languageCode ==
                                                            'ar'
                                                        ? const BorderRadius
                                                            .only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                          )
                                                        : const BorderRadius
                                                            .only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          )),
                                                border: NeumorphicBorder(
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                  width: context.isDarkMode
                                                      ? 0.2
                                                      : 0.8,
                                                )),
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const CustomText(
                                                    'permanent verification'),
                                                const SizedBox(width: 10),
                                                Icon(
                                                  Icons.add_moderator_outlined,
                                                  size: 18,
                                                  color: context.isDarkMode
                                                      ? Colors.white70
                                                      : Colors.black54,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 10, left: 5, right: 5),
                                      child: CustomText(
                                        'This feature provides enhanced protection during purchase transactions, requiring you to enter the verification code with each purchase',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 0),
                                      child: CustomText(
                                        '${'notice'.tr} : ${'Enabling two-factor authentication is required to use this feature'.tr}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 10),
                                        const SizedBox(width: 10),
                                        const CustomText(
                                            'permanent verification'),
                                        const Expanded(child: SizedBox()),
                                        Checkbox(
                                            value: controller
                                                .permanentVerification
                                                .value, //todo need to edit
                                            onChanged: (newValue) {
                                              // controller.sendCodeToEmail(newValue!);
                                              controller
                                                  .changePermanentVerification(
                                                      newValue!); //todo need to edit
                                            }),
                                        const SizedBox(width: 6),
                                      ],
                                    ),
                                    controller.needOtpPermanentWidget.value ==
                                            true
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            child: CustomText(
                                              '${'Your private key has been sent to the email'.tr} ${controller.userModel.email}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    controller.needOtpPermanentWidget.value ==
                                            true
                                        ? Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Pinput(
                                                defaultPinTheme: PinTheme(
                                                  margin:
                                                      const EdgeInsets.all(0),
                                                  width: 48,
                                                  height: 48,
                                                  textStyle: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.grey
                                                                    .shade700
                                                                : Colors.grey
                                                                    .shade300),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                hapticFeedbackType:
                                                    HapticFeedbackType
                                                        .mediumImpact,
                                                onCompleted: (value) {
                                                  controller
                                                      .submitCodeToUpdateProfile(
                                                          verificationCode:
                                                              value);
                                                },
                                                length: 6,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
              ),

              SizedBox(height: Get.height * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      NeumorphicTheme(
                        themeMode: context.isDarkMode
                            ? ThemeMode.dark
                            : ThemeMode.light, //or dark / system
                        darkTheme: const NeumorphicThemeData(
                          baseColor: Color(0xff222222),
                          depth: 6,
                          intensity: 0.3,
                        ),
                        theme: const NeumorphicThemeData(
                          baseColor: Color(0xffffffff),
                          depth: 6,
                          intensity: 0.6,
                        ),
                        child: Neumorphic(
                          style: NeumorphicStyle(
                              lightSource: Get.locale?.languageCode == 'ar'
                                  ? LightSource.left
                                  : LightSource.right,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  Get.locale?.languageCode == 'ar'
                                      ? const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                        )
                                      : const BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        )),
                              border: NeumorphicBorder(
                                color: Colors.deepPurpleAccent,
                                width: context.isDarkMode ? 0.2 : 0.8,
                              )),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText('Change Password'),
                              const SizedBox(width: 10),
                              Icon(
                                Icons.password,
                                size: 18,
                                color: context.isDarkMode
                                    ? Colors.white70
                                    : Colors.black54,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                    child: CustomText(
                      'When password changed, the token api will be changed',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      const SizedBox(width: 10),
                      const CustomText('Change Password'),
                      const Expanded(child: SizedBox()),
                      ElevatedButton(
                          onPressed: () {
                            Get.dialog(ResetPasswordDialog());
                          },
                          child: const Icon(Icons.password_rounded)),
                      const SizedBox(width: 6),
                    ],
                  ),
                  controller.needOtpPermanentWidget.value == true
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          child: CustomText(
                            '${'Your private key has been sent to the email'.tr} ${controller.userModel.email}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  controller.needOtpPermanentWidget.value == true
                      ? Directionality(
                          textDirection: TextDirection.ltr,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Pinput(
                              defaultPinTheme: PinTheme(
                                margin: const EdgeInsets.all(0),
                                width: 48,
                                height: 48,
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: context.isDarkMode
                                          ? Colors.grey.shade700
                                          : Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              hapticFeedbackType:
                                  HapticFeedbackType.mediumImpact,
                              onCompleted: (value) {
                                controller.submitCodeToUpdateProfile(
                                    verificationCode: value);
                              },
                              length: 6,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),

              // ElevatedButton(onPressed: (){
              //   Get.dialog(ResetPasswordDialog());
              // }, child: const CustomText('Change password')),
            ],
          ),
        ),
      ),
    );
  }
}
