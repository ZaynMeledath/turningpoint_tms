part of '../../view/login/login_screen.dart';

typedef SuffixFunction = void Function();

Widget customTextField({
  required TextEditingController controller,
  required String hintText,
  int? maxLines = 1,
  UserController? userController,
  Color? backgroundColor,
  Color? borderColor,
  bool? isPassword,
  bool? isNum,
  bool? isEmail,
  bool? ignoreValidations,
  TextInputType? keyboardType,
  EdgeInsetsGeometry? contentPadding,
  void Function(String)? onChanged,
}) {
  if (userController != null) {
    return Obx(
      () => textField(
        controller: controller,
        hintText: hintText,
        maxLines: maxLines,
        keyboardType: keyboardType,
        userController: userController,
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        isPassword: isPassword,
        isNum: isNum,
        isEmail: isEmail,
        ignoreValidations: ignoreValidations,
        contentPadding: contentPadding,
        onChanged: onChanged,
      ),
    );
  } else {
    return textField(
      controller: controller,
      hintText: hintText,
      maxLines: maxLines,
      userController: null,
      keyboardType: keyboardType,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      isPassword: isPassword,
      isNum: isNum,
      isEmail: isEmail,
      ignoreValidations: ignoreValidations,
      contentPadding: contentPadding,
      onChanged: onChanged,
    );
  }
}

Widget textField({
  required TextEditingController controller,
  required String hintText,
  int? maxLines,
  UserController? userController,
  Color? backgroundColor,
  Color? borderColor,
  bool? isPassword,
  bool? isNum,
  bool? isEmail,
  bool? ignoreValidations,
  TextInputType? keyboardType,
  EdgeInsetsGeometry? contentPadding,
  void Function(String)? onChanged,
}) {
  return TextFormField(
    controller: controller,
    style: GoogleFonts.roboto(),
    maxLines: maxLines,
    maxLength: isNum == true ? 10 : null,
    obscureText: userController != null && isPassword == true
        ? userController.isObScure.value
        : false,
    keyboardAppearance: Brightness.dark,
    cursorOpacityAnimates: true,
    keyboardType: keyboardType ??
        (isEmail == true
            ? TextInputType.emailAddress
            : isNum == true
                ? TextInputType.phone
                : null),
    decoration: InputDecoration(
      counterText: '',
      suffixIcon: userController != null
          ? IconButton(
              icon: Icon(
                isPassword == true
                    ? userController.isObScure.value == true
                        ? Icons.visibility_off
                        : Icons.visibility
                    : null,
              ),
              onPressed: () {
                if (isPassword == true) {
                  userController.isObScure.value =
                      !userController.isObScure.value;
                }
              },
            )
          : null,
      label: Text(
        hintText,
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
      alignLabelWithHint: true,
      contentPadding: contentPadding ??
          EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 13.5.h,
          ),
      fillColor: backgroundColor ?? AppColors.textFieldColor,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: borderColor ?? Colors.transparent,
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
        borderSide: BorderSide(
          color: AppColors.themeGreen.withOpacity(.3),
        ),
      ),
    ),
    onChanged: onChanged,
    validator: (value) {
      if (ignoreValidations == true) {
        return null;
      }
      if (value == null) {
        return 'Invalid value';
      }
      if (value.trim().isEmpty) {
        return '$hintText cannot be empty';
      }

      if (isNum == true) {
        if (value.length != 10) {
          return 'Enter a valid phone number';
        }
      }
      // if (value.length < 3) {
      //   return '$hintText cannot be less than 3 letters';
      // }

      return null;
    },
  );
}
