part of '../assign_task_screen.dart';

Future<Object?> showAssignToDialog({
  required TextEditingController assignToSearchController,
}) async {
  return Get.dialog(
    assignToDialog(
      searchController: assignToSearchController,
    ),
    useSafeArea: true,
    barrierColor: Colors.transparent,
    transitionCurve: Curves.easeInOut,
  );
}

Widget assignToDialog({
  required TextEditingController searchController,
}) {
  final userController = Get.put(UserController());
  final allUsers = userController.myTeamList.value;
  final filterController = FilterController();
  final tasksController = TasksController();

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
          color: AppColor.textFieldColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              SizedBox(height: 8.h),
              Transform.scale(
                scale: .94,
                child: customTextField(
                    controller: TextEditingController(),
                    hintText: 'Search by Name/Email',
                    borderColor: Colors.grey.withOpacity(.3),
                    onChanged: (value) {
                      tasksController.assignToSearchList.value?.clear();
                      tasksController.assignToSearchList.value = allUsers!
                          .where((allUsersModel) => allUsersModel.userName!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    }),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: tasksController.assignToSearchList.value != null
                        ? tasksController.assignToSearchList.value!.length
                        : allUsers?.length,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    itemBuilder: (context, index) {
                      final name =
                          tasksController.assignToSearchList.value != null
                              ? tasksController.assignToSearchList.value![index]
                                      .userName ??
                                  ''
                              : allUsers?[index].userName ?? '';
                      final email =
                          tasksController.assignToSearchList.value != null
                              ? tasksController.assignToSearchList.value![index]
                                      .emailId ??
                                  ''
                              : allUsers?[index].emailId ?? '';

                      return GestureDetector(
                        onTap: () {
                          filterController.selectOrUnselectAssignedToFilter(
                              filterKey: email.toString());
                        },
                        child: Container(
                          color: Colors.transparent,
                          margin: EdgeInsets.only(bottom: 16.h),
                          child: Row(
                            children: [
                              nameLetterAvatar(
                                name: name.toString(),
                                circleDiameter: 32.w,
                              ),
                              SizedBox(width: 8.w),
                              SizedBox(
                                width: 270.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              Obx(
                                () => Material(
                                  color: Colors.transparent,
                                  child: Checkbox.adaptive(
                                    value: filterController
                                            .assignedToFilterModel[email] ??
                                        false,
                                    visualDensity: VisualDensity.compact,
                                    fillColor: WidgetStatePropertyAll(
                                      filterController.assignedToFilterModel[
                                                  email] ==
                                              true
                                          ? AppColor.themeGreen
                                          : Colors.transparent,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    onChanged: (value) {
                                      filterController
                                          .selectOrUnselectAssignedToFilter(
                                              filterKey: email.toString());

                                      if (filterController
                                              .assignedToFilterModel[email] ==
                                          true) {
                                        tasksController.addToAssignToList(
                                          name: name,
                                          email: email,
                                        );
                                      } else {
                                        tasksController.removeFromAssignToList(
                                          email: email,
                                        );
                                      }
                                      debugPrint(tasksController
                                          .assignToList.value?.entries
                                          .toString());
                                    },
                                  ),
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
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
