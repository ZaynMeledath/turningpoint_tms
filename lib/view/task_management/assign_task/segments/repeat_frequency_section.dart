part of '../assign_task_screen.dart';

Widget repeatFrequencySection({required TasksController tasksController}) {
  return Column(
    children: [
      Obx(
        () => Container(
          height: screenHeight * .075,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .03),
          child: Center(
            child: Row(
              children: [
                Icon(
                  Icons.repeat,
                  size: screenWidth * .05,
                ),
                const Gap(4),
                Text(
                  'Repeat',
                  style: TextStyle(
                    fontSize: screenWidth * .041,
                  ),
                ),
                Checkbox(
                  value: tasksController.shouldRepeatTask.value,
                  fillColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return const Color(0xff5d87ff);
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
                            width: screenWidth * .36,
                            child: DropdownButtonFormField(
                              elevation: 2,
                              hint: const Text(
                                'Frequency',
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                              value: tasksController.taskRepeatFrequency.value,
                              borderRadius: BorderRadius.circular(20),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.withOpacity(.25),
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
                              items: const [
                                DropdownMenuItem(
                                  value: RepeatFrequency.daily,
                                  child: Text('Daily'),
                                ),
                                DropdownMenuItem(
                                  value: RepeatFrequency.weekly,
                                  child: Text('Weekly'),
                                ),
                                DropdownMenuItem(
                                  value: RepeatFrequency.monthly,
                                  child: Text('Monthly'),
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
      Gap(screenHeight * .015),
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
