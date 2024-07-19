part of '../assign_task_screen.dart';

Widget monthlyFrequencySegment({required TasksController tasksController}) {
  const rowElementsCount = 8;
  return AnimatedOpacity(
    opacity: tasksController.scaleMonthly.value ? 1 : 0,
    duration: const Duration(milliseconds: 300),
    child: AnimatedSlide(
      offset: tasksController.scaleMonthly.value
          ? const Offset(0, 0)
          : const Offset(0, -.1),
      duration: const Duration(milliseconds: 800),
      curve: Curves.bounceOut,
      child: Container(
        padding: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey.withOpacity(.1),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 6.5.h),
              Text(
                'Select Dates',
                style: TextStyle(
                  fontSize: 15.5.w,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.h),
              for (int i = 0; i < 4; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int j = i * rowElementsCount + 1;
                        j <= (i + 1) * rowElementsCount && j <= totalDays;
                        j++)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                        child: Column(
                          children: [
                            Checkbox(
                              value: tasksController.datesMap[j],
                              fillColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.selected)) {
                                    return const Color.fromRGBO(
                                        36, 196, 123, 1);
                                  }
                                  return Colors.transparent;
                                },
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              visualDensity: VisualDensity.compact,
                              onChanged: (value) {
                                tasksController.datesMap[j] =
                                    value ?? tasksController.datesMap[j]!;
                              },
                            ),
                            Text(
                              tasksController.datesMap.keys
                                  .elementAt(j - 1)
                                  .toString(),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    ),
  );
}
