part of '../assign_task_screen.dart';

Widget repeatFrequencySection({
  required AssignTaskController assignTaskController,
}) {
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
                  value: assignTaskController.shouldRepeatTask.value,
                  fillColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.themeGreen;
                      }
                      return Colors.transparent;
                    },
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  visualDensity: VisualDensity.compact,
                  onChanged: assignTaskController.repeatCheckBoxOnChanged,
                ),
                assignTaskController.shouldRepeatTask.value
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
                              value: assignTaskController
                                  .taskRepeatFrequency.value,
                              borderRadius: BorderRadius.circular(20),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.textFieldColor,
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
                                  assignTaskController.repeatFrequencyOnChanged,
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
        switch (assignTaskController.taskRepeatFrequency.value) {
          case RepeatFrequency.daily:
            return const SizedBox();
          case RepeatFrequency.weekly:
            return weeklyFrequencySegment(
                assignTaskController: assignTaskController);
          case RepeatFrequency.monthly:
            return monthlyFrequencySegment(
                assignTaskController: assignTaskController);
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
