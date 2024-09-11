part of '../profile_screen.dart';

Widget profileOption({
  required String title,
}) {
  return Padding(
    padding: EdgeInsets.only(
      left: 12.w,
      right: 12.w,
      top: 9.h,
      bottom: 9.h,
    ),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 18.sp,
            ),
          ),
        )
      ],
    ),
  );
}
