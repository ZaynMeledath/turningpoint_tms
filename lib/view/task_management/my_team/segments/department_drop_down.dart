part of '../my_team_screen.dart';

Widget departmentDropDown({
  required TasksController tasksController,
  required UserController userController,
}) {
  return DropdownButtonFormField<String>(
    dropdownColor: AppColors.textFieldColor,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 13.5.h,
      ),
      labelText: 'Department',
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
    value: userController.departmentObs.value,
    items: tasksController.categoriesList.map((String department) {
      return DropdownMenuItem<String>(
        value: department,
        child: Text(
          department,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
      );
    }).toList(),
    onChanged: (String? newValue) {
      userController.departmentObs.value = newValue;
    },
  );
}
