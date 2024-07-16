import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/utils/screen_size.dart';
import 'package:turning_point_tasks_app/view/register/register_screen.dart';
import 'package:turning_point_tasks_app/view/task_management/home/tasks_home.dart';

part '../../utils/widgets/custom_text_field.dart';
part '../../utils/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final userController = UserController();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 135),
                      Hero(
                        tag: 'turning_point_logo',
                        child: Image.asset(
                          'assets/images/turning_point_logo.png',
                          width: 110,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          const SizedBox(width: 7),
                          const Text(
                            'Welcome Back Amigo!',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                            ),
                          ).animate().slideX(
                                delay: const Duration(milliseconds: 150),
                                curve: Curves.fastLinearToSlowEaseIn,
                              ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const SizedBox(width: 7),
                          const Text(
                            'Login to your account',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ).animate().slideX(
                                delay: const Duration(milliseconds: 150),
                                curve: Curves.fastLinearToSlowEaseIn,
                              ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      customTextField(
                        controller: emailController,
                        hintText: 'Email',
                        userController: userController,
                        isEmail: true,
                      ).animate().slideX(
                            begin: 1,
                            delay: const Duration(milliseconds: 150),
                            curve: Curves.fastLinearToSlowEaseIn,
                          ),
                      const SizedBox(height: 35),
                      customTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        isPassword: true,
                        userController: userController,
                      ).animate().slideX(
                            begin: 1,
                            delay: const Duration(milliseconds: 150),
                            curve: Curves.fastLinearToSlowEaseIn,
                          ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          child: const Text('Forgot Password'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(
                            () => const TasksHome(),
                          );
                        },
                        child:
                            customButton(buttonTitle: 'Login').animate().scale(
                                  delay: const Duration(milliseconds: 150),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Dont have an Account?'),
                          InkWell(
                            onTap: () {
                              Get.to(
                                () => const RegisterScreen(),
                                transition: Transition.downToUp,
                              );
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'Sign Up here',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(36, 196, 123, 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
