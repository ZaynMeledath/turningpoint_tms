part of '../assign_task_screen.dart';

Widget attatchmentSegment() {
  return Row(
    children: [
      IconButton(
        onPressed: () async {
          await showLinkDialog();
        },
        icon: Icon(
          Icons.link,
          color: Colors.black87,
          size: screenWidth * .06,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.upload_file,
          color: Colors.black87,
          size: screenWidth * .06,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.mic,
          color: Colors.black87,
          size: screenWidth * .06,
        ),
      ),
    ],
  );
}
