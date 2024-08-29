import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';

Future<Object?> showChangeStatusBottomSheet({
  required String taskStatus,
}) {
  return Get.bottomSheet(
    Material(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      color: AppColors.scaffoldBackgroundColor,
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            Text(
              'Mark as $taskStatus',
            ),
          ],
        ),
      ),
    ),
  );
}
