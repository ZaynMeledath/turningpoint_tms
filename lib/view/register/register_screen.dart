import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/utils/screen_size.dart';
import 'package:turning_point_tasks_app/view/login/login_screen.dart';
import 'package:turning_point_tasks_app/view/task_management/test.dart';

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
  final userController = UserController();

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
    userController.dispose();
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
                    const SizedBox(height: 45),
                    Hero(
                      tag: 'turning_point_logo',
                      child: Image.asset(
                        'assets/images/turning_point_logo.png',
                        width: 100,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        SizedBox(width: 7),
                        Text(
                          'Get Started!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        SizedBox(width: 7),
                        Text(
                          'Let\'s get started by filling out the details',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    customTextField(
                      controller: firstNameController,
                      hintText: 'First Name',
                      userController: userController,
                    ),
                    const SizedBox(height: 25),
                    customTextField(
                      controller: lastNameController,
                      hintText: 'Last Name',
                      userController: userController,
                    ),
                    const SizedBox(height: 25),
                    customTextField(
                      controller: phoneController,
                      hintText: 'WhatsApp Number',
                      userController: userController,
                    ),
                    const SizedBox(height: 25),
                    customTextField(
                      controller: emailController,
                      hintText: 'Email',
                      userController: userController,
                    ),
                    const SizedBox(height: 25),
                    customTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      isPassword: true,
                      userController: userController,
                    ),
                    const SizedBox(height: 25),
                    customTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      isPassword: true,
                      userController: userController,
                    ),
                    const SizedBox(height: 34),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(
                          () => const Test(),
                        );
                      },
                      child: customButton(buttonTitle: 'Register'),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        InkWell(
                          onTap: () {
                            Get.offAll(
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
