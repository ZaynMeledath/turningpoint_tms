part of '../my_team_screen.dart';

Widget roleDropDown({
  required UserController userController,
}) {
  final roles = [
    Role.admin,
    Role.teamLeader,
    Role.user,
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
    selectedItemBuilder: (context) {
      return roles.map((String role) {
        return SizedBox(
          width: 300.w,
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 16.sp,
            ),
            child: Text(
              role,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList();
    },
    items: roles.map((String role) {
      return DropdownMenuItem<String>(
        value: role,
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
                      role,
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
      userController.roleObs.value = newValue;
    },
  );
}
