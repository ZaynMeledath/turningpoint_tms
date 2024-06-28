part of '../assign_task_screen.dart';

Widget monthlyFrequencySegment({required TasksController tasksController}) {
  const rowElementsCount = 8;
  log(Get.currentRoute);
  return Container(
    padding: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.grey.withOpacity(.1),
    ),
    child: Center(
      child: Column(
        children: [
          Gap(screenHeight * .007),
          Text(
            'Select Dates',
            style: TextStyle(
              fontSize: screenWidth * .038,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(2),
          for (int i = 0; i < 4; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (int j = i * rowElementsCount + 1;
                    j <= (i + 1) * rowElementsCount && j <= totalDays;
                    j++)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * .0082),
                    child: Column(
                      children: [
                        Checkbox(
                          value: tasksController.datesMap[j],
                          fillColor: WidgetStateProperty.resolveWith<Color?>(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.selected)) {
                                return const Color.fromRGBO(36, 196, 123, 1);
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
                        Text(tasksController.datesMap.keys
                            .elementAt(j - 1)
                            .toString()),
                      ],
                    ),
                  ),
              ],
            ),
        ],
      ),
    ),
  );
}
