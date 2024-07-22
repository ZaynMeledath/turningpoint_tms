import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/filter_controller.dart';
import 'package:turning_point_tasks_app/utils/widgets/name_letter_avatar.dart';
import 'package:turning_point_tasks_app/view/login/login_screen.dart';

Widget assignedFilterSegment({
  required TextEditingController assignedSearchController,
  required FilterController filterController,
  required bool isAssignedBy,
}) {
  return Expanded(
    child: Column(
      children: [
        SizedBox(height: 8.h),
        Flexible(
          child: Transform.scale(
            scale: .94,
            child: customTextField(
              controller: assignedSearchController,
              hintText: 'Search by Name/Email',
            ),
          ),
        )
            .animate(
              key: GlobalKey(),
            )
            .slideX(
              begin: -.06,
              duration: const Duration(milliseconds: 700),
              curve: Curves.elasticOut,
            ),
        SizedBox(height: 4.h),
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            itemBuilder: (context, index) {
              final name = assignedMap.keys.elementAt(index);
              final email = assignedMap.values.elementAt(index);
              return InkWell(
                onTap: () {
                  if (isAssignedBy) {
                    filterController.selectOrUnselectAssignedByFilter(
                        filterKey: email);
                  } else {
                    filterController.selectOrUnselectAssignedToFilter(
                        filterKey: email);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Row(
                    children: [
                      nameLetterAvatar(
                        firstName: name,
                        lastName: ' ',
                        circleDiameter: 32.w,
                      ),
                      SizedBox(width: 8.w),
                      SizedBox(
                        width: 165.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              email,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => Checkbox.adaptive(
                          value: isAssignedBy
                              ? filterController.assignedByFilterModel[email]
                              : filterController.assignedToFilterModel[email],
                          visualDensity: VisualDensity.compact,
                          fillColor: WidgetStatePropertyAll(
                              filterController.assignedByFilterModel[email] ==
                                      true
                                  ? AppColor.themeGreen
                                  : Colors.transparent),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          onChanged: (value) {
                            if (isAssignedBy) {
                              filterController.selectOrUnselectAssignedByFilter(
                                  filterKey: email);
                            } else {
                              filterController.selectOrUnselectAssignedToFilter(
                                  filterKey: email);
                            }
                          },
                        ),
                      ),
                    ],
                  )
                      .animate(
                        key: GlobalKey(),
                      )
                      .slideX(
                        begin: -.06,
                        delay: Duration(milliseconds: 30 * (index + 1)),
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.elasticOut,
                      ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
