import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/utils/open_file.dart';

Future<String?> downloadFile({required String fileUrl}) async {
  final dio = Dio();
  try {
    Get.dialog(const SpinKitWave(
      size: 20,
      color: Colors.white,
    ));
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }

    final attachmentName = fileUrl.split('/').last;
    Directory appDocDir = await getApplicationDocumentsDirectory();

    final savePath = '${appDocDir.path}/$attachmentName';

    final file = File(savePath);

    if (file.existsSync()) {
      Get.back();
      openFile(filePath: savePath);
    } else {
      await dio.download(
        fileUrl,
        savePath,
      );
      Get.back();
      showGenericDialog(
        iconPath: 'assets/lotties/success_animation.json',
        title: 'Downloaded',
        content: 'File has been downloaded to your device',
        buttons: {
          'Cancel': null,
          'Open': () {
            Get.back();
            openFile(filePath: savePath);
          }
        },
      );
    }
    return savePath;
  } catch (_) {
    Get.back();
    showGenericDialog(
      iconPath: 'assets/lotties/server_error_animation.json',
      title: 'Something went wrong',
      content: 'Something went wrong while downloading the file',
      buttons: {'Dismiss': null},
    );
    return null;
  }
}
