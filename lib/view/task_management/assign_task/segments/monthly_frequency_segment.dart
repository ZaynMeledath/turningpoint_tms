part of '../assign_task_screen.dart';

Widget monthlyFrequencySegment({
  required AssignTaskController assignTaskController,
}) {
  const rowElementsCount = 8;
  final totalRows = (totalDays / rowElementsCount).ceil();
  return AnimatedOpacity(
    opacity: assignTaskController.scaleMonthly.value ? 1 : 0,
    duration: const Duration(milliseconds: 400),
    child: AnimatedSlide(
      offset: assignTaskController.scaleMonthly.value
          ? const Offset(0, 0)
          : const Offset(0, -.1),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.elasticOut,
      child: Container(
        padding: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.textFieldColor,
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
              for (int i = 0; i < totalRows; i++)
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
                              value: assignTaskController.datesMap[j],
                              fillColor:
                                  WidgetStateProperty.resolveWith<Color?>(
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
                              onChanged: (value) {
                                assignTaskController.datesMap[j] =
                                    value ?? assignTaskController.datesMap[j]!;
                              },
                            ),
                            Text(
                              assignTaskController.datesMap.keys
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
