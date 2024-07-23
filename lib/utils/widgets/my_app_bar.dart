import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point_tasks_app/utils/flight_shuttle_builder.dart';

AppBar myAppBar({
  required BuildContext context,
  required String title,
  Color? backgroundColor,
  Color? foregroundColor,
  bool implyLeading = true,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 10,
    titleSpacing: 0,
    toolbarHeight: 60.h,
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
                FocusScopeNode currentFocus = FocusScope.of(context);
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
          child: Text(
            title,
            style: GoogleFonts.inter(
              color: foregroundColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ).animate().slideX(
                begin: -.5,
                duration: const Duration(milliseconds: 800),
                curve: Curves.elasticOut,
              ),
        ),
      ],
    ),
  );
}
