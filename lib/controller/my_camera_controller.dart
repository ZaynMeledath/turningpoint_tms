import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/utils/widgets/camera_result_viewer.dart';

class MyCameraController extends GetxController {
  final cameraTabIndexObs = 0.obs;
  final isRecordingVideoObs = false.obs;

  final Rxn<File> clickedPhotoFileObs = Rxn<File>();
  final Rxn<File> recordedVideoFileObs = Rxn<File>();
  final tasksController = Get.put(TasksController());

  void takePicture({
    required CameraController cameraController,
  }) async {
    try {
      clickedPhotoFileObs.value =
          File((await cameraController.takePicture()).path);
      if (clickedPhotoFileObs.value != null) {
        Get.to(() => CameraResultViewer(
            title: 'Image Viewer',
            file: clickedPhotoFileObs.value!,
            isVideo: false,
            onSubmit: () {
              tasksController.addMediaToTaskUpdateAttachments(
                file: clickedPhotoFileObs.value,
              );
              Get.back();
              Get.back();
            }));
      }
    } catch (_) {
      showGenericDialog(
        iconPath: 'assets/lotties/server_error_animation.json',
        title: 'Something went wrong',
        content: 'Something went wrong while taking photo',
        buttons: {
          'OK': null,
        },
      );
    }
  }

  void recordVideo({
    required CameraController cameraController,
  }) async {
    try {
      if (cameraController.value.isRecordingVideo) {
        isRecordingVideoObs.value = false;

        final videoPath = (await cameraController.stopVideoRecording()).path;
        final newPath = videoPath.replaceAll('.temp', '.mp4');
        final videoFile = File(videoPath);
        recordedVideoFileObs.value = await videoFile.rename(newPath);

        if (recordedVideoFileObs.value != null) {
          Get.to(() => CameraResultViewer(
                title: 'Video Player',
                file: recordedVideoFileObs.value!,
                isVideo: true,
                onSubmit: () {
                  tasksController.addMediaToTaskUpdateAttachments(
                    file: recordedVideoFileObs.value,
                  );
                  Get.back();
                  Get.back();
                },
              ));
        }
      } else {
        isRecordingVideoObs.value = true;
        await cameraController.prepareForVideoRecording();
        await cameraController.startVideoRecording();
      }
    } catch (_) {
      isRecordingVideoObs.value = false;
      showGenericDialog(
        iconPath: 'assets/lotties/server_error_animation.json',
        title: 'Something went wrong',
        content: 'Something went wrong while recording video',
        buttons: {
          'OK': null,
        },
      );
    }
  }
}