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
    items: userController.myTeamList.value!
        .where(
            (user) => user.role == Role.admin || user.role == Role.teamLeader)
        .map((AllUsersModel user) {
      return DropdownMenuItem<String>(
        value: user.userName,
        child: Text(
          user.userName ?? '',
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
      );
    }).toList(),
    onChanged: (String? newValue) {
      userController.reportingManagerObs.value = newValue;
    },
  );
}
