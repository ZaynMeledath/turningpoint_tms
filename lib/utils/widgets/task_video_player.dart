import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/utils/download_file.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
import 'package:video_player/video_player.dart';

class TaskVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const TaskVideoPlayer({
    required this.videoUrl,
    super.key,
  });

  @override
  State<TaskVideoPlayer> createState() => _TaskVideoPlayerState();
}

class _TaskVideoPlayerState extends State<TaskVideoPlayer> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  Future<bool> initVideoPlayer() async {
    log('EXECUTED INIT');
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    await _videoPlayerController!.initialize();
    // setState(() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      aspectRatio: _videoPlayerController!.value.aspectRatio,
      autoPlay: true,
      looping: false,
    );
    log('EXECUTED INIT');
    // });
    return true;
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // _future = initVideoPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
            future: initVideoPlayer(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SafeArea(
                  child: Chewie(
                    controller: _chewieController!,
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
            }),
        SizedBox(
          height: 105.w,
          child: myAppBar(
            title: 'Video Player',
            backgroundColor: Colors.black26,
            trailingIcons: [
              IconButton(
                onPressed: () {
                  downloadFile(fileUrl: widget.videoUrl);
                },
                icon: Icon(
                  Icons.download,
                  size: 24.w,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
