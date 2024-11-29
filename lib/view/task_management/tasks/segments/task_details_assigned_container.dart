part of '../task_details_screen.dart';

Widget taskDetailsAssignedContainer({
  required String name,
  required String email,
  required String? profileImg,
  required bool isAssignedBy,
}) {
  final color =
      isAssignedBy ? const Color(0xcc00ACAC) : const Color(0xcc0079D1);
  final profileImageSize = 32.w;
  return InkWell(
    borderRadius: BorderRadius.circular(10),
    onTap: () {
      showTaskDetailsAssignedContainerDialog(
        name: name,
        email: email,
        profileImg: profileImg,
        isAssignedBy: isAssignedBy,
        subContainersColor: color,
      );
    },
    child: Container(
      width: 175.w,
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 245, 245, .07),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              isAssignedBy ? 'Assigned By' : 'Assigned To',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              profileImg != null
                  ? circularUserImage(
                      imageUrl: profileImg,
                      imageSize: profileImageSize,
                      userName: name,
                      border: Border.all(
                        color: color,
                      ),
                    )
                  : nameLetterAvatar(
                      name: name,
                      circleDiameter: profileImageSize,
                      backgroundColor: color,
                    ),
              SizedBox(width: 6.w),
              Expanded(
                child: Container(
                  height: 32.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      name,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            // width: 150.w,
            height: 28.h,
            padding: EdgeInsets.symmetric(
              horizontal: 6.w,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                overflow: TextOverflow.ellipsis,
                email,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
        ],
      ),
    ),
  );
}
