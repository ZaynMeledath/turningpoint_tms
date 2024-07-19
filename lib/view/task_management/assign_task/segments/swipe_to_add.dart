part of '../assign_task_screen.dart';

Widget swipeToAdd() {
  return Container(
    height: 85.h,
    padding: EdgeInsets.symmetric(
      horizontal: 12.w,
    ),
    child: SlideAction(
      height: 65.h,
      sliderRotate: false,
      borderRadius: 50,
      text: 'Add Task',
      textStyle: TextStyle(
        fontSize: 16.sp,
      ),
      innerColor: AppColor.themeGreen,
      outerColor: const Color.fromRGBO(44, 50, 54, 1),
      sliderButtonIcon: const Icon(
        Icons.arrow_forward,
        color: Color.fromRGBO(50, 50, 50, 1),
      ),
      elevation: 2,
      onSubmit: () async {
        await Future.delayed(const Duration(milliseconds: 800));
        Get.back();
      },
    ),
  );
}
