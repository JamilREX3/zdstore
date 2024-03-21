import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../components/customTextField.dart';
import '../controllers/signup_controller.dart';


class SignUpView extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 120),
                  Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16.0),
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
                  CustomTextFormField(
                    contentPadding: const EdgeInsets.symmetric(vertical: 14,horizontal: 16),
                    hintText: 'username',
                    //prefixIcon: Icons.email,
                    prefixIcon: Icons.person,
                    controller: controller.userNameController,
                    labelText: 'username',
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    contentPadding: const EdgeInsets.symmetric(vertical: 14,horizontal: 16),
                    hintText: 'Email',
                    //prefixIcon: Icons.email,
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.emailController,
                    labelText: 'Email',
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    contentPadding: const EdgeInsets.symmetric(vertical: 14,horizontal: 16),
                    hintText: 'Password',
                    prefixIcon: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                    controller: controller.passwordController,
                    obscureText: true,
                    labelText: 'Password',
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: controller.signUp,
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}