import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point_tasks_app/utils/screen_size.dart';
import 'package:turning_point_tasks_app/view/register/register_screen.dart';

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
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const Gap(150),
                      Hero(
                        tag: 'turning_point_logo',
                        child: Image.asset(
                          'assets/images/turning_point_logo.png',
                          width: 100,
                        ),
                      ),
                      const Gap(45),
                      customTextField(
                        controller: emailController,
                        hintText: 'Email',
                      ),
                      const Gap(35),
                      customTextField(
                        controller: passwordController,
                        hintText: 'Password',
                      ),
                      const Gap(10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          child: const Text('Forgot Password'),
                        ),
                      ),
                      const Gap(20),
                      customButton(buttonTitle: 'Login'),
                      const Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Dont have an Account? '),
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                RegisterScreen(),
                                transition: Transition.downToUp,
                              );
                            },
                            child: const Text(
                              'Sign Up here',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(36, 196, 123, 1),
                              ),
                            ),
                          ),
                        ],
                      )
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
