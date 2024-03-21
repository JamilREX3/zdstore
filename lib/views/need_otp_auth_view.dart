import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:zdstore/components/custom_text.dart';
import 'package:zdstore/views/auth_view.dart';
import '../utils/api_request.dart';
class NeedOtpAuth extends StatefulWidget {
  const NeedOtpAuth({super.key});

  @override
  State<NeedOtpAuth> createState() => _NeedOtpAuthState();
}

class _NeedOtpAuthState extends State<NeedOtpAuth> {


  bool loading = false;

  submitCodeToUpdateProfile(
      {required String verificationCode}) async {

    setState(() {
      loading = true;
    });
    // currentState.value = CurrentState.loading;
    var response = await ApiRequest().post(path: '/2fa', body: {
      'code': verificationCode,
    });
    print(response.statusCode);
    print(response.data);
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      print('22222222222222222222');
      Get.offAll(const AuthView());
    } else {
      setState(() {
        loading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomText('Two-factor authentication',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
          const CustomText('Please enter 2 Two-factor authentication code'),
          SizedBox(height: Get.height*0.04),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Pinput(
                defaultPinTheme: PinTheme(
                  margin: const EdgeInsets.all(0),
                  width: 48,
                  height: 48,
                  textStyle: const TextStyle(fontSize: 20,  fontWeight: FontWeight.w600),
                  decoration: BoxDecoration(
                    border: Border.all(color:context.isDarkMode?Colors.grey.shade700:Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                hapticFeedbackType: HapticFeedbackType.mediumImpact,
                onCompleted: (value){
                  submitCodeToUpdateProfile(verificationCode: value);
                  // controller.submitCodeToUpdateProfile(verificationCode: value);
                  print(value);
                },
                length: 6,
              ),
            ),
          )
        ],
      ),
    );
  }
}
