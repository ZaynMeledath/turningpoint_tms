import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/exceptions/user_exceptions.dart';
import 'package:turningpoint_tms/utils/widgets/circular_user_image.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
import 'package:turningpoint_tms/utils/widgets/name_letter_avatar.dart';
import 'package:turningpoint_tms/view/edit_profile/edit_profile_screen.dart';
import 'package:turningpoint_tms/view/login/login_screen.dart';
import 'package:turningpoint_tms/view/task_management/profile/profile_picture_view_screen.dart';
import 'package:turningpoint_tms/view/tickets/my_tickets_screen.dart';
import 'package:turningpoint_tms/view/tickets/raise_ticket_screen.dart';

part 'segments/section_title_container.dart';
part 'segments/profile_option.dart';
part 'dialogs/show_change_password_bottom_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final passwordController = TextEditingController();
  final userController = Get.put(UserController());
  final appController = Get.put(AppController());
  final profileImageLoadingController = AppController();

  final profileImageSize = 85.w;

  @override
  void dispose() {
    passwordController.dispose();
    profileImageLoadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        title: 'Profile',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            children: [
              Obx(
                () => InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    Get.to(
                      () => ProfilePictureViewScreen(),
                    );
                  },
                  child: userController.userObs.value?.profileImg != null
                      ? Hero(
                          tag: 'profile_picture',
                          child: circularUserImage(
                            imageUrl: userController.userObs.value!.profileImg!,
                            imageSize: profileImageSize,
                            userName: '${userController.userObs.value?.name}',
                            border: Border.all(
                              color: AppColors.themeGreen,
                              width: 2.w,
                            ),
                          ),
                        )
                      : Hero(
                          tag: 'profile_picture',
                          child: nameLetterAvatar(
                            name: '${userController.userObs.value?.name}',
                            circleDiameter: profileImageSize,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                '${userController.userObs.value?.name}',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '${userController.userObs.value?.emailId}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white70,
                ),
              ),
              Text(
                '+91 ${userController.userObs.value?.phone}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 8.h),
              sectionTitleContainer(title: 'Account Management'),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Get.to(
                  () => const EditProfileScreen(),
                  transition: Transition.rightToLeft,
                ),
                child: profileOption(title: 'Edit Profile'),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => showChangePasswordBottomSheet(
                  passwordController: passwordController,
                  userController: userController,
                ),
                child: profileOption(title: 'Change Password'),
              ),
              sectionTitleContainer(title: 'Support'),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Get.to(
                    () => MyTicketsScreen(),
                    transition: Transition.rightToLeft,
                  );
                },
                child: profileOption(title: 'My Tickets'),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Get.to(
                    () => RaiseTicketScreen(),
                    transition: Transition.rightToLeft,
                  );
                  // Get.snackbar(
                  //   'Coming Soon...',
                  //   'Feature will be available shortly',
                  // );
                },
                child: profileOption(title: 'Raise a Ticket'),
              ),
              SizedBox(height: 40.h),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      showGenericDialog(
                          iconPath: 'assets/lotties/logout_animation.json',
                          title: 'Log Out?',
                          content: 'Are you sure you want to log out?',
                          iconWidth: 85.w,
                          confirmationButtonColor: Colors.red,
                          buttons: {
                            'Cancel': null,
                            'Log Out': () async {
                              try {
                                if (appController.isLoadingObs.value) {
                                  return;
                                }
                                appController.isLoadingObs.value = true;
                                await userController.logOut();
                                appController.isLoadingObs.value = false;
                                Get.offAll(
                                  () => const LoginScreen(),
                                );
                              } on FcmTokenNullException {
                                appController.isLoadingObs.value = false;
                                Get.back();
                                showGenericDialog(
                                  iconPath:
                                      'assets/lotties/server_error_animation.json',
                                  title: 'Firebase Error',
                                  content:
                                      'Something went wrong while connecting to firebase',
                                  buttons: {
                                    'OK': null,
                                  },
                                );
                                return;
                              } catch (e) {
                                appController.isLoadingObs.value = false;
                                Get.back();
                                showGenericDialog(
                                  iconPath:
                                      'assets/lotties/server_error_animation.json',
                                  title: 'Something went wrong',
                                  content:
                                      'Something went wrong while connecting to server',
                                  buttons: {
                                    'OK': null,
                                  },
                                );
                                return;
                              }
                            }
                          });
                    },
                    child: Container(
                      width: 98.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        // color: const Color.fromRGBO(21, 25, 28, 1),
                        color: Colors.red,
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
                            height: 1,
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
