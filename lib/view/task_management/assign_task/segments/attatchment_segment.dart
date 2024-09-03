part of '../assign_task_screen.dart';

Widget attatchmentSegment({
  required AssignTaskController assignTaskController,
  required AudioRecorder recorder,
  required TextEditingController reminderTimeTextController,
}) {
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
      SizedBox(width: 10.w),
      Icon(
        Icons.upload_file,
        color: Colors.white,
        size: 25.w,
      ),
      SizedBox(width: 18.w),

      Icon(
        Icons.mic,
        color: Colors.white,
        size: 25.w,
      ),
      SizedBox(width: 18.w),
      Obx(
        () => InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            showReminderBottomSheet(
              textController: reminderTimeTextController,
              assignTaskController: assignTaskController,
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.alarm,
                color: Colors.white,
                size: 25.w,
              ),
              assignTaskController.reminderList.isNotEmpty
                  ? Positioned(
                      bottom: 0.w,
                      right: 0.w,
                      child: Container(
                        width: 15.w,
                        height: 15.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                            assignTaskController.reminderList.length.toString(),
                            style: TextStyle(
                              fontSize: 10.w,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
      // assignTaskController.reminderList.isNotEmpty
      //     ? Text(
      //         '${assignTaskController.reminderList.length} Reminder added',
      //         style: TextStyle(
      //           fontSize: 14.sp,
      //         ),
      //       )
      //     : const SizedBox(),
    ],
  );
}
