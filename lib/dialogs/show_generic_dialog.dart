import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';

typedef ButtonFuction = void Function();

Future<Object?> showGenericDialog({
  required String iconPath,
  required String title,
  required String content,
  required Map<String, ButtonFuction?> buttons,
  Color? confirmationButtonColor,
  Color? secondaryButtonBorderColor,
  double? iconWidth,
  bool repeatLottieAnimation = true,
  // Size? containerSize,
}) async {
  return Get.dialog(
    dialog(
      iconPath: iconPath,
      title: title,
      content: content,
      iconWidth: iconWidth,
      confirmationButtonColor: confirmationButtonColor,
      buttons: buttons,
      repeatLottieAnimation: repeatLottieAnimation,
      secondaryButtonBorderColor: secondaryButtonBorderColor,
    ),
    // barrierDismissible: false,
    scaleAnimation: true,
  );
}

Widget dialog({
  required String iconPath,
  required String title,
  required String content,
  required Map<String, ButtonFuction?> buttons,
  required bool repeatLottieAnimation,
  Color? secondaryButtonBorderColor,
  Color? confirmationButtonColor,
  double? iconWidth,
}) {
  final isLottie = iconPath.split('.').last == 'json';
  final appController = Get.put(AppController());

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
            isLottie
                ? Lottie.asset(
                    iconPath,
                    width: iconWidth ?? 61.w,
                    repeat: repeatLottieAnimation,
                  )
                : Image.asset(
                    iconPath,
                    width: iconWidth ?? 61.w,
                  ),
            SizedBox(
              height: isLottie ? 6.h : 12.5.h,
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
            buttons.length > 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < buttons.length; i++)
                        GestureDetector(
                          onTap:
                              buttons.values.elementAt(i) ?? () => Get.back(),
                          child: Obx(
                            () {
                              final isLoading =
                                  appController.isLoadingObs.value;
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 8.h,
                                ),
                                margin: EdgeInsets.only(left: 12.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: i == 0
                                      ? AppColors.scaffoldBackgroundColor
                                      : confirmationButtonColor ??
                                          AppColors.themeGreen,
                                  border: Border.all(
                                    color: i == 0
                                        ? secondaryButtonBorderColor ??
                                            AppColors.themeGreen
                                        : Colors.transparent,
                                  ),
                                ),
                                child: DefaultTextStyle(
                                  style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: i == 0
                                        ? secondaryButtonBorderColor ??
                                            AppColors.themeGreen
                                        : Colors.white,
                                  ),
                                  child: Center(
                                    child:
                                        i == (buttons.length - 1) && isLoading
                                            ? SpinKitWave(
                                                color: Colors.white,
                                                size: 12.w,
                                              )
                                            : Text(
                                                buttons.keys.elementAt(i),
                                                textAlign: TextAlign.center,
                                              ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  )
                : GestureDetector(
                    onTap: buttons.values.first ?? () => Get.back(),
                    child: Container(
                      width: 102.w,
                      height: 36.h,
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
                          child: Text(
                            buttons.keys.first,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    ],
  );
}
