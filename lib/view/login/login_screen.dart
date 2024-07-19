import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
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
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 135.h),
                    Hero(
                      tag: 'turning_point_logo',
                      child: Image.asset(
                        'assets/images/turning_point_logo.png',
                        width: 110,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Row(
                      children: [
                        SizedBox(width: 7.w),
                        Text(
                          'Welcome Back Amigo!',
                          style: TextStyle(
                            fontSize: 26.sp,
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
                        SizedBox(width: 7.w),
                        Text(
                          'Login to your account',
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ).animate().slideX(
                              delay: const Duration(milliseconds: 150),
                              curve: Curves.fastLinearToSlowEaseIn,
                            ),
                      ],
                    ),
                    SizedBox(height: 16.h),
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
                    SizedBox(height: 35.h),
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
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: const Text('Forgot Password'),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(
                          () => const TasksHome(),
                        );
                      },
                      child: customButton(buttonTitle: 'Login').animate().scale(
                            delay: const Duration(milliseconds: 150),
                            curve: Curves.fastLinearToSlowEaseIn,
                          ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont have an Account?',
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => const RegisterScreen(),
                              transition: Transition.downToUp,
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: EdgeInsets.all(5.w),
                            child: Text(
                              'Sign Up here',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColor.themeGreen,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
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
