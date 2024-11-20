import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/utils/widgets/camera_result_viewer.dart';

class MyCameraController extends GetxController {
  final cameraTabIndexObs = 0.obs;
  final isRecordingVideoObs = false.obs;

  final Rxn<File> clickedPhotoFileObs = Rxn<File>();
  final Rxn<File> recordedVideoFileObs = Rxn<File>();

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
            ));
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

        recordedVideoFileObs.value =
            File((await cameraController.stopVideoRecording()).path);

        if (recordedVideoFileObs.value != null) {
          Get.to(() => CameraResultViewer(
                title: 'Video Player',
                file: recordedVideoFileObs.value!,
                isVideo: true,
              ));
        }
      } else {
        isRecordingVideoObs.value = true;
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
