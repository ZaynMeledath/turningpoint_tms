part of '../assign_task_screen.dart';

Widget assignToAndCategorySegment({
  required TasksController tasksController,
  required FilterController filterController,
  required TextEditingController assignToSearchController,
  required TextEditingController categorySearchController,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
//====================Assign To DropDown====================//
      InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => showAssignToDialog(
          tasksController: tasksController,
          filterController: filterController,
          assignToSearchController: assignToSearchController,
        ),
        child: Container(
          width: 156,
          height: 56,
          decoration: BoxDecoration(
            color: AppColor.textFieldColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Obx(
            () {
              final assignToList = tasksController.assignToList;
              if (assignToList.isNotEmpty) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: assignToList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 8.w : 0,
                        right: 8.w,
                      ),
                      child: nameLetterAvatar(
                        name: assignToList.values.elementAt(index),
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

//====================Category DropDown====================//
      InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => showAssignToDialog(
          tasksController: tasksController,
          filterController: filterController,
          assignToSearchController: assignToSearchController,
        ),
        child: Container(
          width: 156,
          height: 56,
          decoration: BoxDecoration(
            color: AppColor.textFieldColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Obx(
            () {
              final assignToList = tasksController.assignToList;
              if (assignToList.isNotEmpty) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: assignToList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 8.w : 0,
                        right: 8.w,
                      ),
                      child: nameLetterAvatar(
                        name: assignToList.values.elementAt(index),
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
                        'Category',
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