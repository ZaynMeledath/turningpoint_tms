part of '../my_team_screen.dart';

Widget roleDropDown({
  required UserController userController,
}) {
  final roles = [
    Role.teamMember,
    Role.teamLeader,
    Role.admin,
  ];
  return DropdownButtonFormField<String>(
    dropdownColor: AppColors.textFieldColor,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 13.5.h,
      ),
      labelText: 'Role',
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
    value: userController.roleObs.value,
    items: roles.map((String role) {
      return DropdownMenuItem<String>(
        value: role,
        child: Text(
          role,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
      );
    }).toList(),
    onChanged: (String? newValue) {
      userController.roleObs.value = newValue;
    },
  );
}
