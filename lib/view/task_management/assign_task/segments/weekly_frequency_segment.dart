part of '../assign_task_screen.dart';

Widget weeklyFrequencySegment({required TasksController tasksController}) {
  return AnimatedOpacity(
    opacity: tasksController.scaleWeekly.value ? 1 : 0,
    duration: const Duration(milliseconds: 400),
    child: AnimatedSlide(
      offset: tasksController.scaleWeekly.value
          ? const Offset(0, 0)
          : const Offset(0, -.1),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.elasticOut,
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
                'Select Days',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (String i in tasksController.daysMap.keys)
                    Column(
                      children: [
                        Checkbox(
                          value: tasksController.daysMap[i],
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
                          onChanged: (value) {
                            tasksController.daysMap[i] =
                                value ?? tasksController.daysMap[i]!;
                          },
                        ),
                        Text(i),
                      ],
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
