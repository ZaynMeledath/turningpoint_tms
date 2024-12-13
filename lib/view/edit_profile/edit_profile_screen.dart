import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/model/user_model.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
import 'package:turningpoint_tms/utils/widgets/name_letter_avatar.dart';
import 'package:turningpoint_tms/view/login/login_screen.dart';
import 'package:turningpoint_tms/view/task_management/profile/profile_picture_view_screen.dart';

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
  final profileImageLoadingController = AppController();
  final updateProfileLoadingController = AppController();
  UserModel? user;

  final profileImageSize = 80.w;

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
    profileImageLoadingController.dispose();
    updateProfileLoadingController.dispose();
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
                Obx(
                  () => Stack(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          Get.to(
                            () => ProfilePictureViewScreen(),
                          );
                        },
                        child: userController.userObs.value?.profileImg != null
                            ? Hero(
                                tag: 'profile_picture',
                                child: Container(
                                  width: profileImageSize,
                                  height: profileImageSize,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          AppColors.themeGreen.withOpacity(.6),
                                      width: 2.w,
                                    ),
                                  ),
                                  child: Center(
                                    child: ClipOval(
                                      child: Image.network(
                                        userController
                                            .userObs.value!.profileImg!,
                                        fit: BoxFit.cover,
                                        width: profileImageSize,
                                        height: profileImageSize,
                                        frameBuilder: (context, child, frame,
                                            wasSynchronouslyLoaded) {
                                          if (wasSynchronouslyLoaded ||
                                              frame != null) {
                                            return child;
                                          } else {
                                            return CupertinoActivityIndicator(
                                              radius: 20.w,
                                            );
                                          }
                                        },
                                      ),
                                    ),
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
                      Positioned(
                        right: 4.w,
                        bottom: 0,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () async {
                            if (profileImageLoadingController
                                .isLoadingObs.value) {
                              return;
                            }
                            try {
                              profileImageLoadingController.isLoadingObs.value =
                                  true;
                              await userController.updateProfilePicture();
                              profileImageLoadingController.isLoadingObs.value =
                                  false;
                            } catch (_) {
                              profileImageLoadingController.isLoadingObs.value =
                                  false;
                              showGenericDialog(
                                iconPath:
                                    'assets/lotties/server_error_animation.json',
                                title: 'Something went wrong',
                                content:
                                    'Something went wrong while changing profile image',
                                buttons: {
                                  'OK': null,
                                },
                              );
                            }
                          },
                          child: Obx(
                            () => Container(
                              width: 22.5.w,
                              height: 22.5.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: Center(
                                child: profileImageLoadingController
                                        .isLoadingObs.value
                                    ? CupertinoActivityIndicator(
                                        radius: 7.w,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.edit,
                                        size: 15.w,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                      updateProfileLoadingController.isLoadingObs.value = true;
                      await userController.updateProfile(
                        name: nameController.text.trim(),
                        phone: phoneController.text.trim(),
                        email: emailController.text.trim(),
                      );
                      updateProfileLoadingController.isLoadingObs.value = false;
                      showGenericDialog(
                        iconPath: 'assets/lotties/success_animation.json',
                        title: 'Profile Updated',
                        content:
                            'Profile details have been successfully updated',
                        buttons: {'OK': null},
                      );
                    } catch (_) {
                      updateProfileLoadingController.isLoadingObs.value = false;
                      showGenericDialog(
                        iconPath: 'assets/lotties/server_error_animation.json',
                        title: 'Something went wrong',
                        content: 'Something went wrong while updating profile',
                        buttons: {'Dismiss': null},
                      );
                    }
                  },
                  child: Obx(
                    () => Container(
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
                        child: updateProfileLoadingController.isLoadingObs.value
                            ? SpinKitWave(
                                size: 16.w,
                                color: Colors.white,
                              )
                            : Text(
                                'Update',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  height: 1,
                                ),
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
