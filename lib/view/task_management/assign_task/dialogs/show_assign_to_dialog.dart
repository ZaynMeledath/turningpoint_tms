part of '../assign_task_screen.dart';

Future<Object?> showAssignToDialog({
  required AssignTaskController assignTaskController,
  required FilterController filterController,
  required TextEditingController assignToSearchController,
  required bool isUpdating,
}) async {
  return Get.dialog(
    assignToDialog(
      assignToSearchController: assignToSearchController,
      assignTaskController: assignTaskController,
      filterController: filterController,
      isUpdating: isUpdating,
    ),
    useSafeArea: true,
    barrierColor: Colors.transparent,
    transitionCurve: Curves.easeInOut,
  );
}

Widget assignToDialog({
  required TextEditingController assignToSearchController,
  required AssignTaskController assignTaskController,
  required FilterController filterController,
  required bool isUpdating,
}) {
  final userController = Get.put(UserController());
  final allUsers = userController.assignTaskUsersList.value;

  // final tasksController = TasksController();

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(height: 320.h),
      Container(
        margin: EdgeInsets.only(
          left: 14.w,
          right: 14.w,
        ),
        height: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.textFieldColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              SizedBox(height: 8.h),
              Transform.scale(
                scale: .94,
                child: customTextField(
                    controller: assignToSearchController,
                    hintText: 'Search by Name/Email',
                    borderColor: Colors.grey.withOpacity(.3),
                    onChanged: (value) {
                      assignTaskController.assignToSearchList.clear();
                      assignTaskController.assignToSearchList.value = allUsers!
                          .where((allUsersModel) => allUsersModel.userName!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    }),
              ),
              allUsers != null
                  ? Expanded(
                      child: Obx(
                        () {
                          final assignToSearchList =
                              assignTaskController.assignToSearchList;
                          return ListView.builder(
                            itemCount: assignToSearchList.isEmpty &&
                                    assignToSearchController.text.trim().isEmpty
                                ? allUsers.length
                                : assignToSearchList.length,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            itemBuilder: (context, index) {
                              // final name =
                              //     tasksController.assignToSearchList.isNotEmpty &&
                              //             searchController.text.isNotEmpty
                              //         ? tasksController
                              //                 .assignToSearchList[index].userName ??
                              //             ''
                              //         : allUsers?[index].userName ?? '';
                              // final email = tasksController
                              //             .assignToSearchList.isNotEmpty &&
                              //         searchController.text.isNotEmpty
                              //     ? tasksController.assignToSearchList[index].emailId ??
                              //         ''
                              //     : allUsers?[index].emailId ?? '';

                              final name = assignToSearchController
                                          .text.isEmpty &&
                                      assignToSearchList.isEmpty
                                  ? allUsers[index].userName ?? ''
                                  : assignToSearchList[index].userName ?? '';

                              final email =
                                  assignToSearchController.text.isEmpty &&
                                          assignToSearchList.isEmpty
                                      ? allUsers[index].emailId ?? ''
                                      : assignToSearchList[index].emailId ?? '';

                              final phone =
                                  assignToSearchController.text.isEmpty &&
                                          assignToSearchList.isEmpty
                                      ? allUsers[index].phone ?? ''
                                      : assignToSearchList[index].phone ?? '';

                              return GestureDetector(
                                onTap: () {
                                  if (isUpdating) {
                                    assignTaskController.assignToMap.value = {
                                      email: AssignedTo(
                                        name: name,
                                        emailId: email,
                                        phone: phone,
                                      ),
                                    };
                                    Get.back();
                                    return;
                                  }
                                  filterController
                                      .selectOrUnselectAssignToUsers(
                                          filterKey: email.toString());

                                  if (filterController
                                          .assignedToFilterModel[email] ==
                                      true) {
                                    assignTaskController.addToAssignToMap(
                                      name: name,
                                      email: email,
                                      phone: phone,
                                      profileImage: allUsers[index].profileImg,
                                    );
                                  } else {
                                    assignTaskController.removeFromAssignToList(
                                      email: email,
                                    );
                                  }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  margin: EdgeInsets.only(bottom: 16.h),
                                  child: Row(
                                    children: [
                                      allUsers[index].profileImg != null
                                          ? circularUserImage(
                                              imageUrl:
                                                  allUsers[index].profileImg!,
                                              imageSize: 32.w,
                                            )
                                          : nameLetterAvatar(
                                              name: name.toString(),
                                              circleDiameter: 32.w,
                                            ),
                                      SizedBox(width: 8.w),
                                      SizedBox(
                                        width: 270.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DefaultTextStyle(
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              child: Text(
                                                name.toString(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            DefaultTextStyle(
                                              style: TextStyle(
                                                color: Colors.white60,
                                                fontSize: 13.sp,
                                              ),
                                              child: Text(
                                                email.toString(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      !isUpdating
                                          ? Obx(
                                              () => Material(
                                                color: Colors.transparent,
                                                child: Checkbox.adaptive(
                                                  value: filterController
                                                              .assignedToFilterModel[
                                                          email] ??
                                                      false,
                                                  visualDensity:
                                                      VisualDensity.compact,
                                                  fillColor:
                                                      WidgetStatePropertyAll(
                                                    filterController.assignedToFilterModel[
                                                                email] ==
                                                            true
                                                        ? AppColors.themeGreen
                                                        : Colors.transparent,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  onChanged: (value) {
                                                    filterController
                                                        .selectOrUnselectAssignToUsers(
                                                            filterKey: email
                                                                .toString());

                                                    if (filterController
                                                                .assignedToFilterModel[
                                                            email] ==
                                                        true) {
                                                      assignTaskController
                                                          .addToAssignToMap(
                                                        name: name,
                                                        email: email,
                                                        phone: phone,
                                                        profileImage:
                                                            allUsers[index]
                                                                .profileImg,
                                                      );
                                                    } else {
                                                      assignTaskController
                                                          .removeFromAssignToList(
                                                        email: email,
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  )
                                      .animate(
                                        key: GlobalKey(),
                                      )
                                      .slideX(
                                        begin: -.03,
                                        delay: Duration(
                                            milliseconds: 6 * (index + 1)),
                                        duration:
                                            const Duration(milliseconds: 600),
                                        curve: Curves.elasticOut,
                                      ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(height: 80.h),
                        Center(
                          child: SpinKitWave(
                            size: 21.w,
                            color: AppColors.themeGreen,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    ],
  );
}
