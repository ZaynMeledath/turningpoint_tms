import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/model/user_model.dart';
import 'package:turningpoint_tms/utils/flight_shuttle_builder.dart';
import 'package:turningpoint_tms/utils/widgets/name_letter_avatar.dart';
import 'package:turningpoint_tms/view/task_management/profile/profile_screen.dart';

AppBar myAppBar({
  required String title,
  Color? backgroundColor,
  Color? foregroundColor,
  List<Widget>? trailingIcons,
  bool profileAvatar = false,
  bool implyLeading = true,
}) {
  final UserModel? user = getUserModelFromHive();
  final profileImageSize = 40.w;
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 10,
    titleSpacing: 0,
    toolbarHeight: 58.w,
    surfaceTintColor: Colors.transparent,
    backgroundColor: backgroundColor ?? Colors.transparent,
    title: Row(
      children: [
        Visibility(
          visible: implyLeading,
          child: Hero(
            tag: 'back_button',
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 24.sp,
                color: foregroundColor,
              ),
              onPressed: () {
                FocusScopeNode currentFocus = FocusScope.of(Get.context!);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                Get.back();
              },
            ),
          ),
        ),
        SizedBox(width: 16.5.w),
        Hero(
            tag: 'title',
            flightShuttleBuilder: flightShuttleBuilder,
            child: SizedBox(
              width: 200.w,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: foregroundColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
            )),
        const Expanded(child: SizedBox()),
        trailingIcons != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  for (Widget widget in trailingIcons)
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: widget,
                    ),
                ],
              )
            : const SizedBox(),
        profileAvatar
            ? Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () => Get.to(
                      () => const ProfileScreen(),
                      transition: Transition.rightToLeft,
                    ),
                    child: user?.profileImg != null
                        ? Container(
                            width: profileImageSize,
                            height: profileImageSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.themeGreen,
                              ),
                            ),
                            child: Center(
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: user!.profileImg!,
                                  fit: BoxFit.cover,
                                  width: profileImageSize,
                                  height: profileImageSize,
                                ),
                              ),
                            ),
                          )
                        : nameLetterAvatar(
                            name: '${user?.name}',
                            circleDiameter: profileImageSize,
                          ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    ),
  );
}
