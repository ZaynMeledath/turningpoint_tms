part of '../assign_task_screen.dart';

Widget weeklyFrequencySegment() {
  final days = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];
  return Container(
    padding: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.grey.withOpacity(.1),
    ),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (String i in days)
            Column(
              children: [
                Checkbox(
                  value: tasksController.daysMap[i],
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
                    tasksController.daysMap[i] =
                        value ?? tasksController.daysMap[i]!;
                  },
                ),
                Text(i),
              ],
            ),
        ],
      ),
    ),
  );
}
