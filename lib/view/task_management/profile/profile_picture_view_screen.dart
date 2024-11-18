import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';

class ProfilePictureViewScreen extends StatefulWidget {
  const ProfilePictureViewScreen({super.key});

  @override
  State<ProfilePictureViewScreen> createState() =>
      _ProfilePictureViewScreenState();
}

class _ProfilePictureViewScreenState extends State<ProfilePictureViewScreen> {
  final userController = Get.put(UserController());
  final profileImageLoadingController = AppController();

  @override
  void dispose() {
    profileImageLoadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final pictureSize = screenSize.width;

    return Scaffold(
      appBar: myAppBar(
        title: 'Profile Picture',
        trailingIcons: [
          Obx(
            () => TextButton(
              onPressed: () async {
                if (profileImageLoadingController.isLoadingObs.value) {
                  return;
                }
                try {
                  profileImageLoadingController.isLoadingObs.value = true;
                  await userController.updateProfilePicture();
                  profileImageLoadingController.isLoadingObs.value = false;
                } catch (_) {
                  profileImageLoadingController.isLoadingObs.value = false;
                  showGenericDialog(
                    iconPath: 'assets/lotties/server_error_animation.json',
                    title: 'Something went wrong',
                    content:
                        'Something went wrong while changing profile image',
                    buttons: {
                      'OK': null,
                    },
                  );
                }
              },
              child: profileImageLoadingController.isLoadingObs.value
                  ? CupertinoActivityIndicator(
                      radius: 10.w,
                      color: Colors.white,
                    )
                  : Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            SizedBox(height: 155.h),
            CachedNetworkImage(
              imageUrl: userController.userObs.value!.profileImg!,
              width: pictureSize,
              height: pictureSize,
              placeholder: (context, url) => Center(
                child: CupertinoActivityIndicator(
                  radius: 20.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
