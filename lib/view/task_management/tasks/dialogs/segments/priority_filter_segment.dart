import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/filter_controller.dart';

Widget priorityFilterSegment({
  required FilterController filterController,
  required int animationFlag,
}) {
  bool shouldAnimate = animationFlag < 1;
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Row(
            children: [
              Icon(
                Icons.flag,
                size: 22.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'Priority',
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
        ),
        Expanded(
          child: ListView.builder(
            itemCount: priorityList.length,
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 4.h,
            ),
            itemBuilder: (context, index) {
              final priority = priorityList[index];
              return InkWell(
                onTap: () => filterController.selectOrUnselectPriorityFilter(
                  filterKey: priority,
                ),
                child: Row(
                  children: [
                    Obx(
                      () => Checkbox.adaptive(
                        value: filterController.priorityFilterModel[priority] ??
                            false,
                        visualDensity: VisualDensity.compact,
                        fillColor: WidgetStatePropertyAll(
                            filterController.priorityFilterModel[priority] ==
                                    true
                                ? AppColors.themeGreen
                                : Colors.transparent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        onChanged: (value) =>
                            filterController.selectOrUnselectPriorityFilter(
                                filterKey: priority),
                      ),
                    ),
                    Text(
                      priority,
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                )
                    .animate(
                      key: GlobalKey(),
                    )
                    .slideX(
                      begin: shouldAnimate ? -.06 : 0,
                      delay: Duration(milliseconds: 30 * (index + 1)),
                      duration: const Duration(milliseconds: 700),
                      curve: shouldAnimate ? Curves.elasticOut : Curves.linear,
                    ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
