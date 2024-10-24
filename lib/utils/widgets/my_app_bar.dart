import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/dialogs/show_reminders_list_dialog.dart';
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
  final UserModel? userModel = getUserModelFromHive();
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 10,
    titleSpacing: 0,
    toolbarHeight: 60.w,
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
              width: 198.w,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: foregroundColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
            // .animate().slideX(
            //       begin: -.5,
            //       duration: const Duration(milliseconds: 800),
            //       curve: Curves.elasticOut,
            //     ),
            ),
        trailingIcons != null
            ? Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    for (Widget widget in trailingIcons)
                      Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: widget,
                      ),
                  ],
                ),
              )
            : Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // IconButton(
                      //   visualDensity: VisualDensity.compact,
                      //   onPressed: () {
                      //     // showRemindersListDialog();
                      //   },
                      //   icon: Icon(
                      //     Icons.notifications,
                      //     size: 24.w,
                      //   ),
                      // ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          showRemindersListDialog();
                        },
                        icon: Icon(
                          Icons.alarm,
                          size: 24.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                    child: nameLetterAvatar(
                      name: '${userModel?.name}',
                      circleDiameter: 40.h,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    ),
  );
}
