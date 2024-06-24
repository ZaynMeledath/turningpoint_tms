import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point_tasks_app/utils/flight_shuttle_builder.dart';
import 'package:turning_point_tasks_app/utils/screen_size.dart';

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
    toolbarHeight: screenHeight * .066,
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
                size: screenWidth * .061,
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
        SizedBox(width: screenWidth * .041),
        Hero(
          tag: title,
          flightShuttleBuilder: flightShuttleBuilder,
          child: Text(
            title,
            style: GoogleFonts.inter(
              color: foregroundColor,
              fontSize: screenWidth * .041,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
