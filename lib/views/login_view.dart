import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zdstore/views/signup_view.dart';
import '../components/customTextField.dart';
import '../components/custom_text.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              'Login',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              hintText: 'Email or username',
              prefixIcon: Icons.email,
              controller: controller.emailController,
              labelText: 'Email or username',
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              hintText: 'Password',
              prefixIcon: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              controller: controller.passwordController,
              obscureText: true,
              labelText: 'Password',

            ),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  //todo Get.to(ForgotPasswordView());
                },
                child:  const CustomText('Forgot Password?'),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: controller.login,
              child:  const CustomText('Login'),
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: (){
                Get.to(SignUpView());
              },
              child:  const CustomText('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}