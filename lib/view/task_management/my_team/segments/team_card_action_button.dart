part of '../my_team_screen.dart';

Widget teamCardActionButton({
  required IconData icon,
  required String title,
  required Color iconColor,
  required void Function() onTap,
  void Function()? onLongPress,
}) {
  Color splashColor = AppColors.themeGreen;

  switch (title) {
    case 'Edit':
      splashColor = Colors.blue;
      break;

    case 'Delete':
      splashColor = Colors.red;
      break;

    default:
      break;
  }
  return InkWell(
    borderRadius: BorderRadius.circular(8),
    splashColor: splashColor,
    onTap: onTap,
    onLongPress: onLongPress,
    child: Container(
      width: 100.w,
      height: 35.h,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: iconColor,
            ),
            SizedBox(width: 4.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
