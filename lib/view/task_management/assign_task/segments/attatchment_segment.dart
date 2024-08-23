part of '../assign_task_screen.dart';

Widget attatchmentSegment() {
  return Row(
    children: [
      // IconButton(
      //   onPressed: () async {
      //     // await showLinkDialog();
      //   },
      //   icon: Icon(
      //     Icons.link,
      //     color: Colors.white,
      //     size: 24.w,
      //   ),
      // ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.upload_file,
          color: Colors.white,
          size: 24.w,
        ),
      ),
      IconButton(
        onPressed: () {
          Get.bottomSheet(
            Container(
              width: double.maxFinite,
              height: 200.h,
              decoration: const BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
            ),
            isDismissible: false,
          );
        },
        icon: Icon(
          Icons.mic,
          color: Colors.white,
          size: 24.w,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.alarm,
          color: Colors.white,
          size: 24.w,
        ),
      ),
    ],
  );
}
