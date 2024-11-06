part of '../assign_task_screen.dart';

Widget assignToAndCategorySegment({
  required AssignTaskController assignTaskController,
  required TasksController tasksController,
  required FilterController filterController,
  required TextEditingController assignToSearchController,
  required TextEditingController categoryNameController,
  required TextEditingController categorySearchController,
  required bool isUpdating,
}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //====================Assign To DropDown====================//
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              showAssignToDialog(
                assignTaskController: assignTaskController,
                filterController: filterController,
                assignToSearchController: assignToSearchController,
                isUpdating: isUpdating,
              );
              assignTaskController.showAssignToEmptyErrorTextObs.value = false;
            },
            child: Obx(
              () => Container(
                width: 156.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: AppColors.textFieldColor,
                  borderRadius: BorderRadius.circular(20),
                  border:
                      assignTaskController.showAssignToEmptyErrorTextObs.value
                          ? Border.all(
                              color: Colors.redAccent,
                            )
                          : null,
                ),
                child: Obx(
                  () {
                    final assignToMap = assignTaskController.assignToMap;
                    if (assignToMap.isNotEmpty) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: assignToMap.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: index == 0 ? 8.w : 0,
                              right: 8.w,
                            ),
                            child: nameLetterAvatar(
                              name: assignToMap.values.elementAt(index).name ??
                                  'patty',
                              circleDiameter: 30.w,
                            ),
                          );
                        },
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Assign To',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white70,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white70,
                              size: 24.w,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),

          //====================Category DropDown====================//
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              showCategoryDialog(
                filterController: filterController,
                assignTaskController: assignTaskController,
                tasksController: tasksController,
                categoryNameController: categoryNameController,
                categorySearchController: categorySearchController,
              );
              assignTaskController.showCategoryEmptyErrorTextObs.value = false;
            },
            child: Obx(
              () => Container(
                width: 156.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: AppColors.textFieldColor,
                  borderRadius: BorderRadius.circular(20),
                  border:
                      assignTaskController.showCategoryEmptyErrorTextObs.value
                          ? Border.all(
                              color: Colors.redAccent,
                            )
                          : null,
                ),
                child: Obx(
                  () {
                    final category = assignTaskController.selectedCategory;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              category.isNotEmpty ? category.value : 'Category',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white70,
                            size: 24.w,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            assignTaskController.showAssignToEmptyErrorTextObs.value
                ? Column(
                    children: [
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Assign To cannot be empty',
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            color: Colors.redAccent.shade100,
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            assignTaskController.showCategoryEmptyErrorTextObs.value
                ? Column(
                    children: [
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Category cannot be empty',
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            color: Colors.redAccent.shade100,
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    ],
  );
}














// return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
// //====================Assign To Dropdown====================//
//       SizedBox(
//         width: 156.w,
//         child: DropdownButtonFormField(
//           elevation: 2,
//           isExpanded: true,
//           hint: Text(
//             tasksController.assignTo.value ?? 'Assign To',
//             style: TextStyle(
//               fontSize: 16.sp,
//               color: Colors.white70,
//             ),
//           ),
//           value: tasksController.assignTo.value,
//           borderRadius: BorderRadius.circular(20),
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: AppColor.textFieldColor,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(
//                 color: Colors.transparent,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(
//                 color: Colors.transparent,
//               ),
//             ),
//           ),
//           items: [
//             for (int i = 0; i < allUsers.length; i++)
//               DropdownMenuItem(
//                 value: allUsers[i].userName,
//                 child: Text(
//                   allUsers[i].userName.toString(),
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                   ),
//                 ),
//               ),
//           ],
//           onChanged: (value) {
//             tasksController.assignTo.value = value.toString();
//           },
//         ),
//       ),

// //====================Task Category Dropdown====================//
//       SizedBox(
//         width: 156.w,
//         child: DropdownButtonFormField(
//           elevation: 2,
//           isExpanded: true,
//           hint: Text(
//             'Category',
//             style: TextStyle(
//               fontSize: 16.sp,
//               color: Colors.white70,
//             ),
//           ),
//           value: tasksController.taskRepeatFrequency.value,
//           borderRadius: BorderRadius.circular(20),
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: AppColor.textFieldColor,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(
//                 color: Colors.transparent,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: const BorderSide(
//                 color: Colors.transparent,
//               ),
//             ),
//           ),
//           items: [
//             for (int i = 0; i < categoriesList.length; i++)
//               DropdownMenuItem(
//                 value: categoriesList[i],
//                 child: Text(
//                   categoriesList[i].toString(),
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                   ),
//                 ),
//               ),
//           ],
//           onChanged: (value) {
//             tasksController.category.value = value.toString();
//           },
//         ),
//       ),
//     ],
//   );