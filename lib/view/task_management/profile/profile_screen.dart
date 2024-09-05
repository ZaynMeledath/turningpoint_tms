import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/model/user_model.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/utils/widgets/name_letter_avatar.dart';
import 'package:turning_point_tasks_app/view/login/login_screen.dart';

part 'segments/section_title_container.dart';
part 'segments/profile_option.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel? userModel =
        Get.put(UserController()).getUserModelFromHive();

    return Scaffold(
      appBar: myAppBar(
        context: context,
        title: 'Profile',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            children: [
              nameLetterAvatar(
                name: '${userModel?.name}',
                circleDiameter: 80.w,
              ),
              SizedBox(height: 10.h),
              Text(
                '${userModel?.name}',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '${userModel?.emailId}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white70,
                ),
              ),
              Text(
                '+91 ${userModel?.phone}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white70,
                ),
              ),
              // Container(
              //   width: 250.w,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(8),
              //     gradient:
              //   ),
              // ),
              // SizedBox(height: 6.h),
              sectionTitleContainer(title: 'Account Management'),
              profileOption(title: 'Edit Profile'),
              profileOption(title: 'Change Password'),
              sectionTitleContainer(title: 'Support'),
              profileOption(title: 'My Tickets'),
              profileOption(title: 'Raise a Ticket'),
              SizedBox(height: 40.h),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      // tasksController.resetTasksController();
                      Get.off(
                        () => const LoginScreen(),
                      );
                    },
                    child: Container(
                      width: 100.w,
                      height: 46.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromRGBO(21, 25, 28, 1),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white38,
                            blurRadius: 1.2,
                            blurStyle: BlurStyle.outer,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
