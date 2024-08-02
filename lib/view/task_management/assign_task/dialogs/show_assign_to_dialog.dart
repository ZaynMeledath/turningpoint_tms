// part of '../assign_task_screen.dart';

// Future<Object?> showAssignToDialog() async {
//   return Get.dialog(
//     useSafeArea: true,
//     barrierColor: Colors.transparent,
//     assignToDialog(),
//     transitionCurve: Curves.easeInOut,
//   );
// }

// Widget assignToDialog() {
//   final userController = Get.put(UserController());
//   final allUsers = userController.myTeamList.value;
//   final filterController = FilterController();

//   return Container(
//     margin: EdgeInsets.only(
//       left: 14.w,
//       right: 14.w,
//       top: 400.h,
//       bottom: 10.h,
//     ),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(16),
//       color: AppColor.textFieldColor,
//     ),
//     child: Column(
//       children: [
//         SizedBox(height: 8.h),
//         Expanded(
//           child: ListView.builder(
//             itemCount: 3,
//             padding: EdgeInsets.symmetric(
//               horizontal: 16.w,
//               vertical: 8.h,
//             ),
//             itemBuilder: (context, index) {
//               final name = allUsers?[index].userName;
//               final email = allUsers?[index].emailId;
//               return GestureDetector(
//                 onTap: () {
//                   filterController.selectOrUnselectAssignedToFilter(
//                       filterKey: email.toString());
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: 16.h),
//                   child: Row(
//                     children: [
//                       nameLetterAvatar(
//                         name: name.toString(),
//                         circleDiameter: 32.w,
//                       ),
//                       SizedBox(width: 8.w),
//                       SizedBox(
//                         width: 250.w,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             DefaultTextStyle(
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                               child: Text(
//                                 name.toString(),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             SizedBox(height: 2.h),
//                             DefaultTextStyle(
//                               style: TextStyle(
//                                 color: Colors.white60,
//                                 fontSize: 13.sp,
//                               ),
//                               child: Text(
//                                 email.toString(),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Obx(
//                         () => Material(
//                           color: Colors.transparent,
//                           child: Checkbox.adaptive(
//                             value:
//                                 filterController.assignedToFilterModel[email] ??
//                                     false,
//                             visualDensity: VisualDensity.compact,
//                             fillColor: WidgetStatePropertyAll(
//                               filterController.assignedToFilterModel[email] ==
//                                       true
//                                   ? AppColor.themeGreen
//                                   : Colors.transparent,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             onChanged: (value) {
//                               filterController.selectOrUnselectAssignedToFilter(
//                                   filterKey: email.toString());
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                       .animate(
//                         key: GlobalKey(),
//                       )
//                       .slideX(
//                         begin: -.06,
//                         delay: Duration(milliseconds: 30 * (index + 1)),
//                         duration: const Duration(milliseconds: 700),
//                         curve: Curves.elasticOut,
//                       ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     ),
//   );
// }
