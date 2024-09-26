import 'dart:developer';

import 'package:get/get.dart';
import 'package:turning_point_tasks_app/dialogs/show_generic_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> showEnableNotificationPermissionDialog() {
  Get.back();
  return showGenericDialog(
    iconPath: 'assets/lotties/notification_animation.json',
    title: 'Permission Required',
    content:
        'Notification permission is required for a seamless user experience',
    buttons: {
      'Goto Settings': () async {
        try {
          final url = Uri.parse('app-settings:');
          await launchUrl(url);
          log('Executed');
        } catch (_) {
          rethrow;
        }
      },
    },
  );
}
