import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/service/api/api_endpoints.dart';
import 'package:turningpoint_tms/service/api/api_service.dart';

class Utils {
  //====================Upload File====================//
  static Future<String> uploadFile({required File file}) async {
    final response = await ApiService().sendRequest(
      url: ApiEndpoints.uploadFile,
      requestMethod: RequestMethod.POST,
      data: file,
      fieldNameForFiles: 'attachments',
      isTokenRequired: true,
    );
    return response.first as String;
  }

//====================Download File====================//
  static Future<String?> downloadFile({required String fileUrl}) async {
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

//====================Open File====================//
  static Future<void> openFile({
    required String filePath,
  }) async {
    try {
      final openResult = await OpenFile.open(filePath);
      if (openResult.type == ResultType.done) {
        return;
      } else if (openResult.type == ResultType.noAppToOpen) {
        showGenericDialog(
          iconPath: 'assets/lotties/server_error_animation.json',
          title: 'No App',
          content: 'You don\'t have any app to open the file',
          buttons: {'OK': null},
        );
      } else {
        showGenericDialog(
          iconPath: 'assets/lotties/server_error_animation.json',
          title: 'Something Went Wrong',
          content:
              'Something went wrong while opening the file. Make sure the file is not deleted',
          buttons: {'Dismiss': null},
        );
      }
    } catch (e) {
      showGenericDialog(
        iconPath: 'assets/lotties/server_error_animation.json',
        title: 'Something Went Wrong',
        content: 'Something went wrong while opening the file',
        buttons: {'Dismiss': null},
      );
    }
  }
}
