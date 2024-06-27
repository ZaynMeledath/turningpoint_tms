part of '../assign_task_screen.dart';

Widget dayFrequencySegment() {
  return Container(
    height: screenHeight * .1,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.grey.withOpacity(.1),
    ),
    child: GridView.builder(
      itemCount: 31,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Checkbox(
              value: tasksController.shouldRepeatTask.value,
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
                tasksController.shouldRepeatTask.value =
                    value ?? tasksController.shouldRepeatTask.value;
                tasksController.taskRepeatFrequency.value = null;
              },
            ),
          ],
        );
      },
    ),
  );
}
