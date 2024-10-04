import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/filter_controller.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/utils/widgets/name_letter_avatar.dart';
import 'package:turning_point_tasks_app/view/login/login_screen.dart';

Widget assignedFilterSegment({
  required TextEditingController assignedSearchController,
  required FilterController filterController,
  required bool isAssignedBy,
  required int animationFlag,
}) {
  bool shouldAnimate = animationFlag < 1;
  final userController = Get.put(UserController());
  final allUsers = userController.myTeamList.value ?? [];
  return Expanded(
    child: Column(
      children: [
        SizedBox(height: 8.h),
        Transform.scale(
          scale: .94,
          child: customTextField(
              controller: assignedSearchController,
              hintText: 'Search by Name/Email',
              onChanged: (value) {
                filterController.assignedSearchList.clear();
                filterController.assignedSearchList.value = allUsers
                    .where((userModel) => userModel.userName!
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
              }),
        ),
        // .animate(
        //   key: GlobalKey(),
        // )
        // .slideX(
        //   begin: -.06,
        //   duration: const Duration(milliseconds: 700),
        //   curve: Curves.elasticOut,
        // ),
        SizedBox(height: 4.h),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: filterController.assignedSearchList.isEmpty &&
                    assignedSearchController.text.trim().isEmpty
                ? allUsers.length
                : filterController.assignedSearchList.length,
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            itemBuilder: (context, index) {
              final name = filterController.assignedSearchList.isEmpty &&
                      assignedSearchController.text.trim().isEmpty
                  ? (userController.myTeamList.value?[index].userName ?? '')
                  : filterController.assignedSearchList[index].userName ?? '';
              final email = filterController.assignedSearchList.isEmpty &&
                      assignedSearchController.text.trim().isEmpty
                  ? (userController.myTeamList.value?[index].emailId ?? '')
                  : filterController.assignedSearchList[index].emailId ?? '';
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
                        name: name,
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
                              ? filterController.assignedByFilterModel[email] ??
                                  false
                              : filterController.assignedToFilterModel[email] ??
                                  false,
                          visualDensity: VisualDensity.compact,
                          fillColor: WidgetStatePropertyAll(
                            filterController.assignedToFilterModel[email] ==
                                        true ||
                                    filterController
                                            .assignedByFilterModel[email] ==
                                        true
                                ? AppColors.themeGreen
                                : Colors.transparent,
                          ),
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
                        begin: shouldAnimate ? -.06 : 0,
                        delay: Duration(milliseconds: 30 * (index + 1)),
                        duration: const Duration(milliseconds: 700),
                        curve:
                            shouldAnimate ? Curves.elasticOut : Curves.linear,
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
