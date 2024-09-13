import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/dialogs/show_generic_dialog.dart';
import 'package:turning_point_tasks_app/model/user_model.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/utils/widgets/name_letter_avatar.dart';
import 'package:turning_point_tasks_app/view/login/login_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final userController = Get.put(UserController());
  UserModel? user;

  @override
  void initState() {
    user = getUserModelFromHive();
    nameController.text = user?.name ?? '';
    phoneController.text = user?.phone ?? '';
    emailController.text = user?.emailId ?? '';
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        title: 'Edit Profile',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).viewInsets.bottom != 0 ? 8.h : 120.h,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 20.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blueGrey.withOpacity(.35),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black,
                  blurRadius: 1.5,
                ),
              ],
            ),
            child: Column(
              children: [
                nameLetterAvatar(
                  name: user?.name ?? '',
                  circleDiameter: 80.w,
                ),
                SizedBox(height: 32.h),
                customTextField(
                  controller: nameController,
                  hintText: 'Name',
                ),
                SizedBox(height: 36.h),
                customTextField(
                  controller: phoneController,
                  hintText: 'WhatsApp Number',
                ),
                SizedBox(height: 36.h),
                customTextField(
                  controller: emailController,
                  hintText: 'Email',
                ),
                SizedBox(height: 36.h),
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    try {
                      await userController.updateProfile(
                        name: nameController.text.trim(),
                        phone: phoneController.text.trim(),
                        email: emailController.text.trim(),
                      );
                      showGenericDialog(
                        iconPath: 'assets/lotties/success_animation.json',
                        title: 'Profile Updated',
                        content:
                            'Profile details have been successfully updated',
                        buttons: {'OK': null},
                      );
                    } catch (_) {
                      showGenericDialog(
                        iconPath: 'assets/lotties/server_error_animation.json',
                        title: 'Something went wrong',
                        content: 'Something went wrong while updating profile',
                        buttons: {'Dismiss': null},
                      );
                    }
                  },
                  child: Container(
                    width: 150.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.themeGreen.withOpacity(.7),
                      border: Border.all(
                        color: AppColors.themeGreen,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 17.sp,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
