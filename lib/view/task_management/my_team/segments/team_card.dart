part of '../my_team_screen.dart';

Widget teamCard({
  required AllUsersModel allUsersModel,
}) {
  final userController = Get.put(UserController());
  final appController = Get.put(AppController());
  final user = getUserModelFromHive();
  Color roleBadgeColor = Colors.teal;

  switch (allUsersModel.role) {
    case Role.admin:
      roleBadgeColor = const Color(0xffDC143C);
      break;

    case Role.teamLeader:
      roleBadgeColor = const Color(0xffDAA520);
      break;

    default:
      break;
  }

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
                SizedBox(
                  width: 200.w,
                  child: Text(
                    allUsersModel.userName.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 105.w,
              padding: EdgeInsets.symmetric(
                // horizontal: 8.w,
                vertical: 4.5.h,
              ),
              decoration: BoxDecoration(
                color: roleBadgeColor.withOpacity(.45),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: roleBadgeColor.withOpacity(.8),
                  width: 1.5.w,
                ),
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
              color: AppColors.themeGreen.withOpacity(.8),
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
              color: AppColors.themeGreen.withOpacity(.8),
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
              color: AppColors.themeGreen.withOpacity(.8),
            ),
            SizedBox(width: 5.w),
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
            SizedBox(width: 25.w),
            Icon(
              Icons.manage_accounts_rounded,
              size: 16.sp,
              color: AppColors.themeGreen.withOpacity(.8),
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: Text(
                allUsersModel.reportingTo != null &&
                        allUsersModel.reportingTo!.isNotEmpty
                    ? allUsersModel.reportingTo.toString()
                    : 'Self',
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
        (user!.role == Role.admin || allUsersModel.reportingTo == user.name) &&
                allUsersModel.id != user.id
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  teamCardActionButton(
                    icon: Icons.edit,
                    title: 'Edit',
                    iconColor: Colors.blue,
                    onTap: () {
                      showAddTeamMemberBottomSheet(userModel: allUsersModel);
                    },
                  ),
                  SizedBox(width: 30.w),
                  teamCardActionButton(
                    icon: Icons.delete,
                    title: 'Delete',
                    iconColor: Colors.red,
                    onTap: () => showGenericDialog(
                      iconPath: 'assets/lotties/delete_animation.json',
                      title: 'Delete User?',
                      content:
                          'Are you sure you want to delete this team member?',
                      confirmationButtonColor: Colors.red,
                      buttons: {
                        'Cancel': null,
                        'Delete': () async {
                          try {
                            appController.isLoadingObs.value = true;
                            await userController.deleteTeamMember(
                                memberId: allUsersModel.id!);
                            appController.isLoadingObs.value = false;
                            Get.back();

                            showGenericDialog(
                              iconPath: 'assets/lotties/deleted_animation.json',
                              title: 'Deleted',
                              content: 'User has been successfully deleted',
                              buttons: {'OK': null},
                            );
                          } catch (_) {
                            Get.back();
                            appController.isLoadingObs.value = false;
                            showGenericDialog(
                              iconPath:
                                  'assets/lotties/server_error_animation.json',
                              title: 'Something went wrong',
                              content:
                                  'Something went wrong while deleting the user',
                              buttons: {'Dismiss': null},
                            );
                            return;
                          }
                        }
                      },
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ],
    ),
  );
}
