import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zdstore/components/custom_text.dart';
import 'package:zdstore/controllers/reset_password_controller.dart';
import '../components/customTextField.dart';
import '../components/custom_snackbar.dart';
import '../utils/api_request.dart';

class ResetPasswordDialog extends StatelessWidget {
  const ResetPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordController());
    return GetBuilder<ResetPasswordController>(
      builder:(controller)=> AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        // backgroundColor: Colors.red,
        surfaceTintColor: Colors.white,
        title: const CustomText('Change Password'),
        content: SingleChildScrollView(
          child: Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              if (controller.loading.value) const LinearProgressIndicator(),
              CustomTextFormField(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: controller.currentPasswordController,
                suffixIconSize: 18,
                labelText: 'Current Password',
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: controller.newPasswordController,
                suffixIconSize: 18,
                labelText: 'New Password',
              ),
              controller.newPasswordValidator.value==false?const SizedBox(height: 8):SizedBox(),
              PasswordRequirement(
                'Must contain an uppercase letter',
                controller.hasUppercase.value,
              ),
              PasswordRequirement(
                'Must contain a lowercase letter',
                controller.hasLowercase.value,
              ),
              PasswordRequirement(
                'Must contain a digit',
                controller.hasDigits.value,
              ),
              PasswordRequirement(
                'Must contain a symbol',
                controller.hasSymbol.value,
              ),
              PasswordRequirement(
                'Must be at least 6 characters in length',
                controller.hasSixCharacters.value,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: controller.confirmPasswordController,
                suffixIconSize: 18,
                labelText: 'Confirm Password',
              ),
              PasswordRequirement(
                'Passwords must match', // New condition
                controller.passwordsMatch.value,
              ),
            ],
          )),
        ),
        actions: [
          TextButton(
              onPressed: () => Get.back(), child: const CustomText('Cancel')),
          TextButton(
              onPressed: (){
                controller.changePassword();
              },
              child: const CustomText('Change Password')),
        ],
      ),
    );
  }
}

class PasswordRequirement extends StatelessWidget {
  final String requirement;
  final bool whenValid;

  const PasswordRequirement(this.requirement, this.whenValid, {super.key});

  @override
  Widget build(BuildContext context) {
    return whenValid==true?const SizedBox():CustomText(requirement, style:  const TextStyle(color: Colors.redAccent,fontSize: 12));
  }
}
