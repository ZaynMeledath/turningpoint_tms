import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';

class MyCameraController extends GetxController {
  final cameraTabIndexObs = 0.obs;
  final isRecordingVideoObs = false.obs;

  final Rxn<File> clickedPhotoObs = Rxn<File>();
  final Rxn<File> recordedVideoFileObs = Rxn<File>();

  void takePicture({
    required CameraController cameraController,
  }) async {
    try {
      clickedPhotoObs.value = File((await cameraController.takePicture()).path);
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
