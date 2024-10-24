// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
        alignment: Alignment.topCenter,
        scale: curve,
        child: const RemindersListDialog(),
      );
    },
  );
}

class RemindersListDialog extends StatefulWidget {
  const RemindersListDialog({super.key});

  @override
  State<RemindersListDialog> createState() => _RemindersListDialogState();
}

class _RemindersListDialogState extends State<RemindersListDialog> {
  final GlobalKey _containerKey = GlobalKey();
  double _mainContainerHeight = 200.w;
  int? notificationListLength = 3;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (notificationListLength != null && notificationListLength! > 0) {
          final RenderBox renderBox =
              _containerKey.currentContext!.findRenderObject() as RenderBox;
          final subContainerHeight = renderBox.size.height;
          final screenHeight = MediaQuery.of(Get.context!).size.height;
          _mainContainerHeight =
              (notificationListLength! * (subContainerHeight + 10)) + 66.w;
          if (_mainContainerHeight > (screenHeight - 350.h)) {
            _mainContainerHeight = screenHeight - 350;
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          //====================Reminder Container====================//
          Column(
            children: [
              SizedBox(height: 60.w),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 3.0,
                  sigmaY: 3.0,
                ),
                child: Container(
                  height: _mainContainerHeight,
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.scaffoldBackgroundColor,
                    border: Border.all(
                      color: Colors.blueGrey.withOpacity(.2),
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
                        //====================Reminders====================//
                        Expanded(
                          child: notificationListLength != null &&
                                  notificationListLength! > 0
                              ? ListView.builder(
                                  itemCount: notificationListLength,
                                  itemBuilder: (context, index) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          left: 12.w,
                                          right: 12.w,
                                          bottom: 10.w,
                                        ),
                                        child: Container(
                                          key:
                                              index == 0 ? _containerKey : null,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12.w,
                                            vertical: 8.w,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color.fromRGBO(48, 78, 85, .4),
                                                Color.fromRGBO(29, 36, 41, 1),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            border: Border.all(
                                              color: Colors.blueGrey
                                                  .withOpacity(.3),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Reminder Message',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              SizedBox(height: 2.w),
                                              Row(
                                                children: [
                                                  Text(
                                                    '24 Oct 2024',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Text(
                                                    '10:00 PM',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                  })
                              : notificationListLength == null
                                  ? const SizedBox()
                                  : Lottie.asset(
                                      'assets/lotties/empty_list_animation.json',
                                      width: 110.w,
                                    ),
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
}

// Widget remindersListDialog() {
//   const notificationListLength = 5;
//   int containerHeight = ((notificationListLength * 64.h) + 60.h).toInt();

//   if (containerHeight > (MediaQuery.of(Get.context!).size.height - 350.h)) {
//     containerHeight = (MediaQuery.of(Get.context!).size.height - 350).toInt();
//   }
  
// }
