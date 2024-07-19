import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/view/login/login_screen.dart';
import 'package:turning_point_tasks_app/view/task_management/home/tasks_dashboard.dart';

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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 48.h),
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
                  SizedBox(height: 12.h),
                  customTextField(
                    controller: firstNameController,
                    hintText: 'First Name',
                    userController: userController,
                  ).animate().slideX(
                        delay: const Duration(milliseconds: 100),
                        curve: Curves.fastLinearToSlowEaseIn,
                      ),
                  SizedBox(height: 25.h),
                  customTextField(
                    controller: lastNameController,
                    hintText: 'Last Name',
                    userController: userController,
                  ).animate().slideX(
                        begin: 1,
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
                          color: Colors.grey.withOpacity(.1),
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
                          userController: userController,
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
                    userController: userController,
                    isEmail: true,
                  ).animate().slideX(
                        begin: 1,
                        delay: const Duration(milliseconds: 100),
                        curve: Curves.fastLinearToSlowEaseIn,
                      ),
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
                  GestureDetector(
                    onTap: () {
                      Get.offAll(
                        () => const TasksDashboard(),
                      );
                    },
                    child:
                        customButton(buttonTitle: 'Register').animate().scale(
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
                              color: AppColor.themeGreen,
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
