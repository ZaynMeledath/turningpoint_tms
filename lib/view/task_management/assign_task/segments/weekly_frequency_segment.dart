part of '../assign_task_screen.dart';

Widget weeklyFrequencySegment({required TasksController tasksController}) {
  return AnimatedOpacity(
    opacity: tasksController.scaleWeekly.value ? 1 : 0,
    duration: const Duration(milliseconds: 300),
    child: AnimatedSlide(
      offset: tasksController.scaleWeekly.value
          ? const Offset(0, 0)
          : const Offset(0, -.1),
      duration: const Duration(milliseconds: 800),
      curve: Curves.bounceOut,
      child: Container(
        padding: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey.withOpacity(.1),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: screenHeight * .007),
              Text(
                'Select Days',
                style: TextStyle(
                  fontSize: screenWidth * .038,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
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
            ],
          ),
        ),
      ),
    ),
  );
}
