part of '../assign_task_screen.dart';

Widget repeatFrequencySection({required TasksController tasksController}) {
  return Column(
    children: [
      Obx(
        () => Container(
          height: 68.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Center(
            child: Row(
              children: [
                Icon(
                  Icons.repeat,
                  size: 20.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Repeat',
                  style: TextStyle(
                    fontSize: 20.sp,
                  ),
                ),
                Checkbox(
                  value: tasksController.shouldRepeatTask.value,
                  fillColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColor.themeGreen;
                      }
                      return Colors.transparent;
                    },
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  visualDensity: VisualDensity.compact,
                  onChanged: tasksController.repeatCheckBoxOnChanged,
                ),
                tasksController.shouldRepeatTask.value
                    ? Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 148.w,
                            child: DropdownButtonFormField(
                              elevation: 2,
                              hint: Text(
                                'Frequency',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white70,
                                ),
                              ),
                              value: tasksController.taskRepeatFrequency.value,
                              borderRadius: BorderRadius.circular(20),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromRGBO(44, 50, 54, 1),
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
                                DropdownMenuItem(
                                  value: RepeatFrequency.daily,
                                  child: Text(
                                    'Daily',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: RepeatFrequency.weekly,
                                  child: Text(
                                    'Weekly',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: RepeatFrequency.monthly,
                                  child: Text(
                                    'Monthly',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged:
                                  tasksController.repeatFrequencyOnChanged,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 13.5.h),
//====================Day Frequency Segment====================//
      Obx(() {
        switch (tasksController.taskRepeatFrequency.value) {
          case RepeatFrequency.daily:
            return const SizedBox();
          case RepeatFrequency.weekly:
            return weeklyFrequencySegment(tasksController: tasksController);
          case RepeatFrequency.monthly:
            return monthlyFrequencySegment(tasksController: tasksController);
          default:
            return const SizedBox();
        }
      }),
    ],
  );
}


// Expanded(
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: SizedBox(
//                   height: 50,
//                   width: 150,
//                   child: DropdownSearch(
//                     selectedItem: 'Frequency',
//                     items: const [
//                       'Daily',
//                       'Weekly',
//                       'Monthly',
//                     ],
//                   ),
//                 ),
//               ),
//             ),
