part of '../task_details_screen.dart';

Widget taskDetailsTitleContent({
  required String title,
  required String content,
  bool? addAvatar,
  Color? contentColor,
  Icon? iconWidget,
}) {
  return Row(
    children: [
      SizedBox(
        width: 140.w,
        child: Text(
          '$title : ',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white60,
          ),
        ),
      ),
      SizedBox(width: 4.w),
      iconWidget != null
          ? Row(
              children: [
                iconWidget,
                SizedBox(width: 6.w),
              ],
            )
          : const SizedBox(),
      addAvatar == true
          ? Row(
              children: [
                nameLetterAvatar(
                  firstName: content.split(' ')[0],
                  lastName: content.split(' ')[1],
                  circleDiameter: 30.w,
                ),
                SizedBox(width: 8.w),
              ],
            )
          : const SizedBox(),
      Expanded(
        child: Text(
          content,
          style: TextStyle(
            fontSize: 15.sp,
            color: contentColor,
            height: 1.5,
          ),
        ),
      ),
    ],
  );
}
