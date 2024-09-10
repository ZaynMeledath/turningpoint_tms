import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/app_controller.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/view/login/login_screen.dart';

Future<Object?> addTeamMemberBottomSheet() {
  return Get.bottomSheet(
    isScrollControlled: true,
    const AddTeamMemberBottomSheet(),
  );
}

class AddTeamMemberBottomSheet extends StatefulWidget {
  const AddTeamMemberBottomSheet({
    super.key,
  });

  @override
  State<AddTeamMemberBottomSheet> createState() =>
      AddTeamMemberBottomSheetState();
}

class AddTeamMemberBottomSheetState extends State<AddTeamMemberBottomSheet> {
  final tasksController = Get.put(TasksController());
  final appController = Get.put(AppController());
  final userController = Get.put(UserController());
  final GlobalKey<FormState> _formKey = GlobalKey();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  Color? taskStatusColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Material(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
          color: AppColors.scaffoldBackgroundColor,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //====================Title====================//
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 14.h,
                  ),
                  child: Text(
                    'Add to Team',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: 1,
                  color: Colors.white12,
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        customTextField(
                          controller: nameController,
                          hintText: 'Name',
                        ),
                        customTextField(
                          controller: nameController,
                          hintText: 'WhatsApp Number',
                          isNum: true,
                        ),
                        customTextField(
                          controller: nameController,
                          hintText: 'Email',
                        ),
                        customTextField(
                          controller: nameController,
                          hintText: 'Password',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
