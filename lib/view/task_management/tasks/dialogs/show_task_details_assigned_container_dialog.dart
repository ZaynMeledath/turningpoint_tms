part of '../task_details_screen.dart';

Future<Object?> showTaskDetailsAssignedContainerDialog({
  required String name,
  required String email,
  required bool isAssignedBy,
  required subContainersColor,
}) async {
  return Get.dialog(
    taskDetailsAssignedContainerDialog(
      name: name,
      email: email,
      isAssignedBy: isAssignedBy,
      subContainersColor: subContainersColor,
    ),
    useSafeArea: true,
    barrierColor: Colors.transparent,
    transitionCurve: Curves.easeInOut,
    scaleAnimation: true,
  );
}

Widget taskDetailsAssignedContainerDialog({
  required String name,
  required String email,
  required bool isAssignedBy,
  required subContainersColor,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 7.0,
          sigmaY: 7.0,
        ),
        child: Container(
          // width: 300.w,
          margin: EdgeInsets.symmetric(
            horizontal: 36.w,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 25.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.textFieldColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  child: Text(
                    isAssignedBy ? 'Assigned By' : 'Assigned To',
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  nameLetterAvatar(
                    name: name,
                    circleDiameter: 45.w,
                    backgroundColor: subContainersColor,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Container(
                      // width: 200.w,
                      height: 45.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                      ),
                      decoration: BoxDecoration(
                        color: subContainersColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.1,
                          ),
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            name,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Container(
                height: 43.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 6.w,
                ),
                decoration: BoxDecoration(
                  color: subContainersColor.withOpacity(.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      email,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    ],
  );
}
