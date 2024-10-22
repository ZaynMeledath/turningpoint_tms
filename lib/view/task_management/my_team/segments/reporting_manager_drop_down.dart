part of '../my_team_screen.dart';

Widget reportingManagerDropDown({
  required UserController userController,
}) {
  return DropdownButtonFormField<String>(
    dropdownColor: AppColors.textFieldColor,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 13.5.h,
      ),
      labelText: 'Reporting Manager',
      labelStyle: TextStyle(
        fontSize: 16.sp,
      ),
      fillColor: AppColors.textFieldColor,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColors.themeGreen.withOpacity(.3),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
    ),
    value: userController.reportingManagerObs.value,
    selectedItemBuilder: (context) {
      return userController.myTeamList.value!
          .where(
              (user) => user.role == Role.admin || user.role == Role.teamLeader)
          .map((AllUsersModel user) {
        return SizedBox(
          width: 300.w,
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 16.sp,
            ),
            child: Text(
              user.userName.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList();
    },
    items: userController.myTeamList.value!
        .where(
            (user) => user.role == Role.admin || user.role == Role.teamLeader)
        .map((AllUsersModel user) {
      return DropdownMenuItem<String>(
        value: user.userName,
        child: Padding(
          padding: EdgeInsets.only(
            top: 6.h,
            bottom: 6.h,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.blueGrey.withOpacity(.4),
              ),
            ),
            child: Row(
              children: [
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                  child: const Text(
                    '⦿',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.w),
                SizedBox(
                  width: 150.w,
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                    child: Text(
                      user.userName ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList(),
    onChanged: (String? newValue) {
      userController.reportingManagerObs.value = newValue;
    },
  );
}
