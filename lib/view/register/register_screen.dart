import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/utils/screen_size.dart';
import 'package:turning_point_tasks_app/view/login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: Transform.scale(
              scale: scaleFactor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    Hero(
                      tag: 'turning_point_logo',
                      child: Image.asset(
                        'assets/images/turning_point_logo.png',
                        width: 100,
                      ),
                    ),
                    const SizedBox(height: 30),
                    customTextField(
                      controller: firstNameController,
                      hintText: 'First Name',
                    ),
                    const SizedBox(height: 25),
                    customTextField(
                      controller: lastNameController,
                      hintText: 'Last Name',
                    ),
                    const SizedBox(height: 25),
                    customTextField(
                      controller: phoneController,
                      hintText: 'WhatsApp Number',
                    ),
                    const SizedBox(height: 25),
                    customTextField(
                      controller: emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(height: 25),
                    customTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      suffixIcon: Icons.visibility_off,
                    ),
                    const SizedBox(height: 25),
                    customTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      suffixIcon: Icons.visibility_off,
                    ),
                    const SizedBox(height: 34),
                    customButton(buttonTitle: 'Register'),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        InkWell(
                          onTap: () {
                            Get.off(
                              () => const LoginScreen(),
                              transition: Transition.downToUp,
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: const Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'Login here',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(36, 196, 123, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
