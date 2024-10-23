// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';

Future<Object?> showRemindersListDialog() async {
  return showGeneralDialog(
    context: Get.context!,
    // barrierDismissible: true,
    barrierColor: Colors.transparent,
    pageBuilder: (context, a1, a2) {
      return Container();
    },
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, a1, a2, child) {
      final curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        alignment: Alignment.topRight,
        scale: curve,
        child: remindersListDialog(),
      );
    },
  );
}

Widget remindersListDialog() {
  const notificationListLength = 5;
  int containerHeight = ((notificationListLength * 64.h) + 60.h).toInt();

  if (containerHeight > (MediaQuery.of(Get.context!).size.height - 100.h)) {
    containerHeight = (MediaQuery.of(Get.context!).size.height - 100).toInt();
  }
  return SafeArea(
    child: Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            color: Colors.transparent,
          ),
        ),
        Column(
          children: [
            SizedBox(height: 60.w),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 3.0,
                sigmaY: 3.0,
              ),
              child: Container(
                height: containerHeight.toDouble(),
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.textFieldColor,
                  border: Border.all(
                    color: Colors.blueGrey.withOpacity(.3),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 4.w,
                          right: 10.w,
                          top: 12.w,
                          bottom: 4.w,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                size: 24.w,
                              ),
                            ),
                            Text(
                              'Reminders',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: notificationListLength,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: const ExpansionTile(
                                  title: Text('Testing'),
                                  children: [
                                    Text(
                                      'Testing Expansion Tile',
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
