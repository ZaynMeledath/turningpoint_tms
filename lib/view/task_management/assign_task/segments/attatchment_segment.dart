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
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.upload_file,
          color: Colors.white,
          size: 24.w,
        ),
      ),
      IconButton(
        onPressed: () async {
          // final appDir = await getApplicationDocumentsDirectory();
          // if (assignTaskController.isRecording.value) {
          //   assignTaskController.voiceRecordPath.value =
          //       await recorder.stop() ?? '';
          // } else {
          //   recorder.start(
          //     const RecordConfig(),
          //     path: '${appDir.path}/myRecording.wav',
          //   );
          // }
        },
        icon: Icon(
          Icons.mic,
          color: Colors.white,
          size: 24.w,
        ),
      ),
      IconButton(
        onPressed: () {
          showReminderBottomSheet(
            textController: reminderTimeTextController,
            assignTaskController: assignTaskController,
          );
        },
        icon: Icon(
          Icons.alarm,
          color: Colors.white,
          size: 24.w,
        ),
      ),
    ],
  );
}
