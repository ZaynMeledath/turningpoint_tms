import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' show Obx;
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/filter_controller.dart';

Widget dateRangeFilter({
  required FilterController filterController,
  required int animationFlag,
}) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                size: 22.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'Select Date Range',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
              .animate(
                key: GlobalKey(),
              )
              .slideX(
                begin: -.06,
                duration: const Duration(milliseconds: 700),
                curve: Curves.elasticOut,
              ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 48.w,
                    child: Center(
                      child: Text(
                        'Start Date',
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  )
                      .animate(
                        key: GlobalKey(),
                      )
                      .slideX(
                        begin: -.06,
                        delay: const Duration(milliseconds: 30),
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.elasticOut,
                      ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 48.w,
                    child: Center(
                      child: Text(
                        'End Date',
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  )
                      .animate(
                        key: GlobalKey(),
                      )
                      .slideX(
                        begin: -.06,
                        delay: const Duration(milliseconds: 90),
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.elasticOut,
                      ),
                ],
              ),
              SizedBox(width: 12.w),
              Column(
                children: [
                  Obx(
                    () {
                      final date =
                          filterController.selectedStartDate.value?.day;
                      final month =
                          filterController.selectedStartDate.value?.month;
                      final year =
                          filterController.selectedStartDate.value?.year;
                      return Container(
                        width: 130.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.textFieldColor,
                        ),
                        child: Center(
                          child: Text(
                            filterController.selectedStartDate.value != null
                                ? '$date/$month/$year'
                                : 'dd/mm/yyyy',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color:
                                  filterController.selectedEndDate.value == null
                                      ? Colors.white38
                                      : null,
                            ),
                          ),
                        ),
                      )
                          .animate(
                            key: GlobalKey(),
                          )
                          .slideX(
                            begin: -.06,
                            delay: const Duration(milliseconds: 60),
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.elasticOut,
                          );
                    },
                  ),
                  SizedBox(height: 16.h),
                  Obx(
                    () {
                      final date = filterController.selectedEndDate.value?.day;
                      final month =
                          filterController.selectedEndDate.value?.month;
                      final year = filterController.selectedEndDate.value?.year;
                      return Container(
                        width: 130.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.textFieldColor,
                        ),
                        child: Center(
                          child: Text(
                            filterController.selectedEndDate.value != null
                                ? '$date/$month/$year'
                                : 'dd/mm/yyyy',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color:
                                  filterController.selectedEndDate.value == null
                                      ? Colors.white38
                                      : null,
                            ),
                          ),
                        ),
                      )
                          .animate(
                            key: GlobalKey(),
                          )
                          .slideX(
                            begin: -.06,
                            delay: const Duration(milliseconds: 120),
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.elasticOut,
                          );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
