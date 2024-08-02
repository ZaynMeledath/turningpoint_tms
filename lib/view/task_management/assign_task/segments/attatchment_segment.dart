part of '../assign_task_screen.dart';

Widget attatchmentSegment() {
  return Row(
    children: [
      IconButton(
        onPressed: () async {
          // await showLinkDialog();
        },
        icon: Icon(
          Icons.link,
          color: Colors.white,
          size: 24.w,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.upload_file,
          color: Colors.white,
          size: 24.w,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.mic,
          color: Colors.white,
          size: 24.w,
        ),
      ),
    ],
  );
}
