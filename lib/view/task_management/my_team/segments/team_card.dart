part of '../my_team_screen.dart';

Widget teamCard({
  required AllUsersModel allUsersModel,
}) {
  final userController = Get.put(UserController());
  final userModel = userController.getUserModelFromHive();
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 14.w,
      vertical: 12.h,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(48, 78, 85, .4),
          Color.fromRGBO(29, 36, 41, 1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(
        color: Colors.grey.withOpacity(.3),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
//====================DP, Name and Role====================//
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                nameLetterAvatar(
                  name: allUsersModel.userName.toString(),
                  circleDiameter: 34,
                  backgroundColor: Colors.blue,
                ),
                SizedBox(width: 8.w),
                Text(
                  allUsersModel.userName.toString(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  allUsersModel.role.toString(),
                  style: TextStyle(
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
//====================Email, Phone, Reporting Manager====================//
        Row(
          children: [
            Icon(
              Icons.email,
              size: 16.sp,
              color: AppColor.themeGreen.withOpacity(.8),
            ),
            SizedBox(width: 6.w),
            Text(
              allUsersModel.emailId.toString(),
              style: TextStyle(
                fontSize: 14.5.sp,
                color: Colors.white60,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(
              Icons.phone,
              size: 16.sp,
              color: AppColor.themeGreen.withOpacity(.8),
            ),
            SizedBox(width: 6.w),
            Text(
              '+91 ${allUsersModel.phone}',
              style: TextStyle(
                fontSize: 14.5.sp,
                color: Colors.white60,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(
              Icons.work,
              size: 16.sp,
              color: AppColor.themeGreen.withOpacity(.8),
            ),
            SizedBox(width: 6.w),
            Text(
              allUsersModel.department != null &&
                      allUsersModel.department!.isNotEmpty
                  ? allUsersModel.department.toString()
                  : '-',
              style: TextStyle(
                fontSize: 14.5.sp,
                color: Colors.white60,
              ),
            ),
            SizedBox(width: 30.w),
            Icon(
              Icons.manage_accounts_rounded,
              size: 16.sp,
              color: AppColor.themeGreen.withOpacity(.8),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                allUsersModel.reportingTo != null &&
                        allUsersModel.reportingTo!.isNotEmpty
                    ? allUsersModel.reportingTo.toString()
                    : '-',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.5.sp,
                  color: Colors.white60,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
//====================Buttons====================//
        userModel?.role == Role.admin || userModel?.role == Role.teamLeader
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  teamCardActionButton(
                    icon: Icons.edit,
                    title: 'Edit',
                    iconColor: Colors.blue,
                    onTap: () {},
                  ),
                  SizedBox(width: 30.w),
                  teamCardActionButton(
                    icon: Icons.delete,
                    title: 'Delete',
                    iconColor: Colors.red,
                    onTap: () {},
                  ),
                ],
              )
            : const SizedBox(),
      ],
    ),
  );
}
