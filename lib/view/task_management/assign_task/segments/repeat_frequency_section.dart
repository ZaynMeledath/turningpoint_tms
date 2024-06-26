part of '../assign_task_screen.dart';

Widget repeatFrequencySection() {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * .03),
        child: Row(
          children: [
            Icon(
              Icons.repeat,
              size: screenWidth * .06,
            ),
            const Gap(4),
            Text(
              'Repeat',
              style: TextStyle(
                fontSize: screenWidth * .04,
              ),
            ),
            Checkbox(
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
              value: true,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    ],
  );
}
