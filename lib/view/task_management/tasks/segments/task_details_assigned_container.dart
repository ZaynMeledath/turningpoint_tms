part of '../task_details_screen.dart';

Widget taskDetailsAssignedContainer({
  required String name,
  required bool isAssignedBy,
}) {
  final color =
      isAssignedBy ? const Color(0xff00ACAC) : const Color(0xff0079D1);
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 12.w,
      vertical: 12.h,
    ),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(255, 245, 245, .1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        nameLetterAvatar(
          name: name,
          circleDiameter: 32.w,
          backgroundColor: color,
        ),
        SizedBox(width: 6.w),
        Container(
          width: 120.w,
          height: 32.h,
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              overflow: TextOverflow.ellipsis,
              name,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
