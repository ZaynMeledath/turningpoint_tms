import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/assign_task_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
import 'package:video_player/video_player.dart';

class CameraResultViewer extends StatefulWidget {
  final String title;
  final File file;
  final bool isVideo;
  final String currentRoute;
  final AssignTaskController? assignTaskController;
  const CameraResultViewer({
    required this.title,
    required this.file,
    required this.isVideo,
    required this.currentRoute,
    required this.assignTaskController,
    super.key,
  });

  @override
  State<CameraResultViewer> createState() => _CameraResultViewerState();
}

class _CameraResultViewerState extends State<CameraResultViewer> {
  VideoPlayerController? videoController;
  final tasksController = Get.put(TasksController());

  @override
  void initState() {
    if (widget.isVideo) {
      initVideoPlayer();
    }

    super.initState();
  }

  ChewieController? chewieController;

  Future<bool> initVideoPlayer() async {
    videoController = VideoPlayerController.file(widget.file);
    await videoController!.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoController!,
      zoomAndPan: true,
      aspectRatio: videoController!.value.aspectRatio,
      autoPlay: true,
      looping: false,
    );
    return true;
  }

  @override
  void dispose() {
    videoController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        title: widget.title,
        backgroundColor: Colors.black,
        trailingIcons: [
          TextButton(
            onPressed: () async {
              switch (widget.currentRoute) {
                case '/ChangeStatusBottomSheet':
                  tasksController.addMediaToTaskUpdateAttachments(
                    file: widget.file,
                  );
                  Get.back();
                  Get.back();
                  break;

                case '/AssignTaskScreen':
                  widget.assignTaskController
                      ?.addFileAttachment(mediaFile: widget.file);
                  Get.back();
                  Get.back();
                  break;

                default:
                  break;
              }
            },
            child: Text(
              'Done',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      body: widget.isVideo
          ? FutureBuilder(
              future: initVideoPlayer(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SafeArea(
                    child: Chewie(
                      controller: chewieController!,
                    ),
                  );
                } else {
                  return Center(
                    child: SpinKitWave(
                      color: AppColors.themeGreen,
                      size: 22.w,
                    ),
                  );
                }
              })
          : PhotoView(
              imageProvider: FileImage(widget.file),
            ),
    );
  }
}



// SizedBox(
//           height: 105.w,
//           child: myAppBar(
//             title: widget.title,
//             backgroundColor: Colors.black26,
//             trailingIcons: [
//               TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   'Done',
//                   style: TextStyle(
//                     fontSize: 15.sp,
//                     color: Colors.blue,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         )