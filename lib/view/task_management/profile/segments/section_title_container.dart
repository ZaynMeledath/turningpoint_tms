part of '../profile_screen.dart';

Widget sectionTitleContainer({required String title}) {
  return Container(
    width: double.maxFinite,
    padding: EdgeInsets.symmetric(
      horizontal: 12.w,
      vertical: 12.h,
    ),
    margin: EdgeInsets.only(
      top: 16.h,
      bottom: 12.h,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.black.withOpacity(.3),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 14.5.sp,
        color: Colors.white60,
      ),
    ),
  );
}
