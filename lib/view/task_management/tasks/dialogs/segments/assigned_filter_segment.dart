import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/filter_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/utils/widgets/circular_user_image.dart';
import 'package:turningpoint_tms/utils/widgets/name_letter_avatar.dart';
import 'package:turningpoint_tms/view/login/login_screen.dart';

Widget assignedFilterSegment({
  required TextEditingController assignedSearchController,
  required FilterController filterController,
  required bool isAssignedBy,
  required int animationFlag,
}) {
  final profileImageSize = 32.w;
  bool shouldAnimate = animationFlag < 1;
  final userController = Get.put(UserController());
  final allUsers = userController.assignTaskUsersList.value ?? [];
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
                if (isAssignedBy) {
                  filterController.assignedBySearchList.clear();
                  filterController.assignedBySearchList.value = allUsers
                      .where((userModel) => userModel.userName!
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                } else {
                  filterController.assignedToSearchList.clear();
                  filterController.assignedToSearchList.value = allUsers
                      .where((userModel) => userModel.userName!
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                }
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
            itemCount: isAssignedBy
                ? filterController.assignedBySearchList.isEmpty &&
                        assignedSearchController.text.trim().isEmpty
                    ? allUsers.length
                    : filterController.assignedBySearchList.length
                : filterController.assignedToSearchList.isEmpty &&
                        assignedSearchController.text.trim().isEmpty
                    ? allUsers.length
                    : filterController.assignedToSearchList.length,
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            itemBuilder: (context, index) {
              String name = '';
              String email = '';
              String profileImg = '';

              if (isAssignedBy) {
                name = filterController.assignedBySearchList.isEmpty &&
                        assignedSearchController.text.trim().isEmpty
                    ? (userController
                            .assignTaskUsersList.value?[index].userName ??
                        '')
                    : filterController.assignedBySearchList[index].userName ??
                        '';

                email = filterController.assignedBySearchList.isEmpty &&
                        assignedSearchController.text.trim().isEmpty
                    ? (userController
                            .assignTaskUsersList.value?[index].emailId ??
                        '')
                    : filterController.assignedBySearchList[index].emailId ??
                        '';

                profileImg = filterController.assignedBySearchList.isEmpty &&
                        assignedSearchController.text.trim().isEmpty
                    ? (userController
                            .assignTaskUsersList.value?[index].profileImg ??
                        '')
                    : filterController.assignedBySearchList[index].profileImg ??
                        '';
              } else {
                name = filterController.assignedToSearchList.isEmpty &&
                        assignedSearchController.text.trim().isEmpty
                    ? (userController
                            .assignTaskUsersList.value?[index].userName ??
                        '')
                    : filterController.assignedToSearchList[index].userName ??
                        '';

                email = filterController.assignedToSearchList.isEmpty &&
                        assignedSearchController.text.trim().isEmpty
                    ? (userController
                            .assignTaskUsersList.value?[index].emailId ??
                        '')
                    : filterController.assignedToSearchList[index].emailId ??
                        '';

                profileImg = filterController.assignedToSearchList.isEmpty &&
                        assignedSearchController.text.trim().isEmpty
                    ? (userController
                            .assignTaskUsersList.value?[index].profileImg ??
                        '')
                    : filterController.assignedToSearchList[index].profileImg ??
                        '';
              }

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
                      profileImg.isNotEmpty
                          ? circularUserImage(
                              imageUrl: profileImg,
                              imageSize: profileImageSize,
                              userName: name,
                            )
                          : nameLetterAvatar(
                              name: name,
                              circleDiameter: profileImageSize,
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
                            (filterController.assignedToFilterModel[email] ==
                                            true &&
                                        !isAssignedBy) ||
                                    (filterController
                                                .assignedByFilterModel[email] ==
                                            true &&
                                        isAssignedBy)
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
