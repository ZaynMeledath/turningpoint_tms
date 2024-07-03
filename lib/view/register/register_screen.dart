import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
            child: Transform.scale(
              scale: scaleFactor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Gap(70),
                    Hero(
                      tag: 'turning_point_logo',
                      child: Image.asset(
                        'assets/images/turning_point_logo.png',
                        width: 100,
                      ),
                    ),
                    const Gap(30),
                    customTextField(
                      controller: firstNameController,
                      hintText: 'First Name',
                    ),
                    const Gap(25),
                    customTextField(
                      controller: lastNameController,
                      hintText: 'Last Name',
                    ),
                    const Gap(25),
                    customTextField(
                      controller: phoneController,
                      hintText: 'WhatsApp Number',
                    ),
                    const Gap(25),
                    customTextField(
                      controller: emailController,
                      hintText: 'Email',
                    ),
                    const Gap(25),
                    customTextField(
                      controller: passwordController,
                      hintText: 'Password',
                    ),
                    const Gap(25),
                    customTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                    ),
                    const Gap(32),
                    customButton(buttonTitle: 'Register'),
                    const Gap(16),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? '),
                        Text(
                          'Login here',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(36, 196, 123, 1),
                          ),
                        ),
                      ],
                    ),
                    const Gap(15),
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
