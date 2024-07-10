part of '../my_tasks_screen.dart';

Widget cardActionButton({
  required String title,
  required IconData icon,
  required Color iconColor,
}) =>
    Container(
      width: 70,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 18,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
