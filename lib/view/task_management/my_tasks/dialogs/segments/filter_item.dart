part of '../../my_tasks_screen.dart';

Widget filterItem({
  required String title,
  required bool isActive,
}) {
  return Container(
    width: double.maxFinite,
    height: 45.h,
    color: isActive ? Colors.grey.withOpacity(.15) : Colors.transparent,
    child: Row(
      children: [
        isActive
            ? Container(
                width: 15.w,
                height: double.maxFinite,
                color: AppColor.themeGreen,
              )
            : const SizedBox(),
        SizedBox(width: 10.w),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
