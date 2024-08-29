import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

typedef ButtonFuction = void Function();

Future<Object?> showAnimatedGenericDialog({
  required BuildContext context,
  required String iconPath,
  required String title,
  required String content,
  required Map<String, ButtonFuction?> buttons,
  double? iconWidth,
  // Size? containerSize,
}) async {
  return Get.dialog(
    dialog(
      context: context,
      iconPath: iconPath,
      title: title,
      content: content,
      iconWidth: iconWidth,
      buttons: buttons,
    ),
    transitionDuration: const Duration(milliseconds: 300),
    transitionCurve: Curves.easeInOut,
  );
}

Widget dialog({
  required BuildContext context,
  required String iconPath,
  required String title,
  required String content,
  required Map<String, ButtonFuction?> buttons,
  double? iconWidth,
}) {
  final isLottie = iconPath.split('.').last == 'json';

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            isLottie
                ? Lottie.asset(
                    iconPath,
                    width: iconWidth ?? 61.w,
                  )
                : Image.asset(
                    iconPath,
                    width: iconWidth ?? 61.w,
                  ),
            SizedBox(
              height: isLottie ? 4.5.h : 12.5.h,
            ),
            DefaultTextStyle(
              style: GoogleFonts.roboto(
                fontSize: 18.5.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
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
                color: Colors.black,
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
                          onTap: buttons.values.elementAt(i) ??
                              () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            margin: EdgeInsets.only(left: 12.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: i == 0
                                  ? Colors.white
                                  : const Color.fromRGBO(0, 99, 255, 1),
                              border: Border.all(
                                color: i == 0
                                    ? const Color.fromRGBO(0, 99, 255, 1)
                                    : Colors.transparent,
                              ),
                            ),
                            child: DefaultTextStyle(
                              style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: i == 0
                                    ? const Color.fromRGBO(0, 99, 255, 1)
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  buttons.keys.elementAt(i),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                : GestureDetector(
                    onTap: buttons.values.first ?? () => Navigator.pop(context),
                    child: Container(
                      width: 102.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromRGBO(0, 99, 255, 1),
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
