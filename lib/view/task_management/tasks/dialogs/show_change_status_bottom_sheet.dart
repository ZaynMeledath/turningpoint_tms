import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';

Future<Object?> showChangeStatusBottomSheet({
  required String taskStatus,
}) {
  return Get.bottomSheet(
    const ChangeStatusBottomSheet(),
  );
}

class ChangeStatusBottomSheet extends StatefulWidget {
  const ChangeStatusBottomSheet({super.key});

  @override
  State<ChangeStatusBottomSheet> createState() =>
      ChangeStatusBottomSheetState();
}

class ChangeStatusBottomSheetState extends State<ChangeStatusBottomSheet> {
  late final TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      color: AppColors.scaffoldBackgroundColor,
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 12.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task Update',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
