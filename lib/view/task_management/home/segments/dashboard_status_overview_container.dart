part of '../tasks_dashboard.dart';

Widget dashboardStatusOverviewContainer({
  required String status,
  required int count,
  required IconData icon,
  required Color iconColor,
}) {
  final screenWidth = MediaQuery.of(Get.context!).size.width;
  return Container(
    width: screenWidth * .29,
    // width: 120.w,
    height: 64.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: const Color.fromRGBO(21, 25, 28, 1),
      boxShadow: const [
        BoxShadow(
          color: Colors.white38,
          blurRadius: 1.2,
          blurStyle: BlurStyle.outer,
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        SizedBox(width: 4.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              status,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
