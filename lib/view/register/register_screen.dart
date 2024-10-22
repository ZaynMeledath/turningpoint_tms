// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/view/login/login_screen.dart';
import 'package:turningpoint_tms/view/task_management/home/tasks_home.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  // late final TextEditingController departmentController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  final userController = UserController();
  final appController = Get.put(AppController());

  @override
  void initState() {
    nameController = TextEditingController();
    // departmentController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    // departmentController.dispose();
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
            reverse: MediaQuery.viewInsetsOf(context).bottom != 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 60.h),
                  Hero(
                    tag: 'turning_point_logo',
                    child: Image.asset(
                      'assets/images/turning_point_logo.png',
                      width: 100.w,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      SizedBox(width: 7.w),
                      Text(
                        'Get Started!',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      SizedBox(width: 7.w),
                      Text(
                        'Let\'s get started by filling out the details',
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  customTextField(
                    controller: nameController,
                    hintText: 'Name',
                    // userController: userController,
                  ).animate().slideX(
                        delay: const Duration(milliseconds: 100),
                        curve: Curves.fastLinearToSlowEaseIn,
                      ),
                  SizedBox(height: 25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.textFieldColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            '+91',
                            style: GoogleFonts.roboto(),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: customTextField(
                          controller: phoneController,
                          hintText: 'WhatsApp Number',
                          // userController: userController,
                          isNum: true,
                        ),
                      ),
                    ],
                  ).animate().slideX(
                        delay: const Duration(milliseconds: 100),
                        curve: Curves.fastLinearToSlowEaseIn,
                      ),
                  SizedBox(height: 25.h),
                  customTextField(
                    controller: emailController,
                    hintText: 'Email',
                    isEmail: true,
                  ).animate().slideX(
                        begin: 1,
                        delay: const Duration(milliseconds: 100),
                        curve: Curves.fastLinearToSlowEaseIn,
                      ),
                  // SizedBox(height: 25.h),
                  // customTextField(
                  //   controller: departmentController,
                  //   hintText: 'Department',
                  // ).animate().slideX(
                  //       begin: 1,
                  //       delay: const Duration(milliseconds: 100),
                  //       curve: Curves.fastLinearToSlowEaseIn,
                  //     ),
                  SizedBox(height: 25.h),
                  customTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    isPassword: true,
                    userController: userController,
                  ).animate().slideX(
                        delay: const Duration(milliseconds: 100),
                        curve: Curves.fastLinearToSlowEaseIn,
                      ),
                  SizedBox(height: 25.h),
                  customTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    isPassword: true,
                    userController: userController,
                  ).animate().slideX(
                        begin: 1,
                        delay: const Duration(milliseconds: 100),
                        curve: Curves.fastLinearToSlowEaseIn,
                      ),
                  SizedBox(height: 34.h),
                  Obx(
                    () => customButton(
                      buttonTitle: 'Register',
                      isLoading: appController.isLoadingObs.value,
                      onTap: () async {
                        appController.isLoadingObs.value = true;
                        try {
                          await userController.register(
                            name: nameController.text.trim(),
                            phone: phoneController.text.trim(),
                            email: emailController.text.trim(),
                            department: 'Admin',
                            role: 'Admin',
                            password: passwordController.text.trim(),
                          );
                          appController.isLoadingObs.value = false;
                          Get.offAll(
                            () => const TasksHome(),
                          );
                        } catch (e) {
                          appController.isLoadingObs.value = false;
                          showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              title: Text('Error'),
                              content: Text('Something Went Wrong'),
                            ),
                          );
                        }
                      },
                    ).animate().scale(
                          delay: const Duration(milliseconds: 100),
                          curve: Curves.fastLinearToSlowEaseIn,
                        ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.offAll(
                            () => const LoginScreen(),
                            transition: Transition.downToUp,
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Padding(
                          padding: EdgeInsets.all(5.w),
                          child: Text(
                            'Login here',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.themeGreen,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
