import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/filter_controller.dart';

Widget frequencyFilterSegment({
  required FilterController filterController,
}) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            'Frequency',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
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
        ),
        Expanded(
          child: ListView.builder(
            itemCount: frequencyList.length,
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            itemBuilder: (context, index) {
              final frequency = frequencyList[index];
              return InkWell(
                onTap: () => filterController.selectOrUnselectFrequencyFilter(
                    filterKey: frequency),
                child: Row(
                  children: [
                    Obx(
                      () => Checkbox.adaptive(
                        value:
                            filterController.frequencyFilterModel[frequency] ??
                                false,
                        visualDensity: VisualDensity.compact,
                        fillColor: WidgetStatePropertyAll(
                            filterController.frequencyFilterModel[frequency] ==
                                    true
                                ? AppColors.themeGreen
                                : Colors.transparent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        onChanged: (value) =>
                            filterController.selectOrUnselectFrequencyFilter(
                                filterKey: frequency),
                      ),
                    ),
                    Text(
                      frequency,
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
                      begin: -.06,
                      delay: Duration(milliseconds: 30 * (index + 1)),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.elasticOut,
                    ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
