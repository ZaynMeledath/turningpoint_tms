import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/model/tasks_model.dart';

typedef ButtonFuction = void Function();

Future<Object?> showDeleteRecurringTasksDialog({
  required String iconPath,
  required String title,
  required String content,
  required TasksController tasksController,
  required TaskModel taskModel,
}) async {
  return Get.dialog(
    dialog(
      iconPath: iconPath,
      title: title,
      content: content,
      tasksController: tasksController,
      taskModel: taskModel,
    ),
    // barrierDismissible: false,
    scaleAnimation: true,
  );
}

Widget dialog({
  required String iconPath,
  required String title,
  required String content,
  required TasksController tasksController,
  required TaskModel taskModel,
}) {
  final deleteAllController = AppController();
  final deleteSingleController = AppController();

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 255.w,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        // margin: EdgeInsets.symmetric(horizontal: 58.w),
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Lottie.asset(
              iconPath,
              width: 61.w,
            ),
            SizedBox(
              height: 6.h,
            ),
            DefaultTextStyle(
              style: GoogleFonts.roboto(
                fontSize: 18.5.sp,
                fontWeight: FontWeight.w500,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 11.h),
            DefaultTextStyle(
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
              child: Text(
                content,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    try {
                      deleteAllController.isLoadingObs.value = true;
                      await tasksController.deleteTask(
                        taskId: taskModel.id.toString(),
                        groupId: taskModel.groupId,
                      );

                      deleteAllController.isLoadingObs.value = false;
//########## Task Deleted Dialog code is written inside the ws initialization method in main.dart ##########//
                    } catch (_) {
                      deleteAllController.isLoadingObs.value = false;
                      showGenericDialog(
                        iconPath: 'assets/lotties/server_error_animation.json',
                        title: 'Something Went Wrong',
                        content:
                            'Something went wrong while connecting to the server',
                        buttons: {
                          'Dismiss': null,
                        },
                      );
                    }
                  },
                  child: Obx(
                    () {
                      final isLoading = deleteAllController.isLoadingObs.value;
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        margin: EdgeInsets.only(right: 12.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.scaffoldBackgroundColor,
                          border: Border.all(
                            color: Colors.red,
                          ),
                        ),
                        child: DefaultTextStyle(
                          style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                          child: Center(
                            child: isLoading
                                ? SpinKitWave(
                                    color: Colors.white,
                                    size: 12.w,
                                  )
                                : Text(
                                    'All Recurring',
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      deleteSingleController.isLoadingObs.value = true;
                      await tasksController.deleteTask(
                        taskId: taskModel.id.toString(),
                      );

                      deleteSingleController.isLoadingObs.value = false;
//########## Task Deleted Dialog code is written inside the ws initialization method in main.dart ##########//
                    } catch (_) {
                      deleteSingleController.isLoadingObs.value = false;
                      showGenericDialog(
                        iconPath: 'assets/lotties/server_error_animation.json',
                        title: 'Something Went Wrong',
                        content:
                            'Something went wrong while connecting to the server',
                        buttons: {
                          'Dismiss': null,
                        },
                      );
                    }
                  },
                  child: Obx(
                    () {
                      final isLoading =
                          deleteSingleController.isLoadingObs.value;
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.themeGreen,
                        ),
                        child: DefaultTextStyle(
                          style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          child: Center(
                            child: isLoading
                                ? SpinKitWave(
                                    color: Colors.white,
                                    size: 12.w,
                                  )
                                : Text(
                                    'Just This',
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
