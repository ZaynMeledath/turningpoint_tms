part of '../assign_task_screen.dart';

Widget assignToAndCategorySegment({
  required TasksController tasksController,
}) {
  final userController = Get.put(UserController());
  var allUsers = <AllUsersModel>[];
  if (userController.myTeamList.value != null) {
    allUsers = userController.myTeamList.value!;
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => showAssignToDialog(),
        child: Container(
          width: 156,
          height: 56,
          decoration: BoxDecoration(
            color: AppColor.textFieldColor,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      SizedBox(
        width: 156.w,
        child: DropdownButtonFormField(
          elevation: 2,
          isExpanded: true,
          hint: Text(
            'Category',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white70,
            ),
          ),
          value: tasksController.taskRepeatFrequency.value,
          borderRadius: BorderRadius.circular(20),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.textFieldColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
          items: [
            for (int i = 0; i < categoriesList.length; i++)
              DropdownMenuItem(
                value: categoriesList[i],
                child: Text(
                  categoriesList[i].toString(),
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ),
          ],
          onChanged: (value) {
            tasksController.category.value = value.toString();
          },
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