part of '../../view/login/login_screen.dart';

typedef SuffixFunction = void Function();

Widget customTextField({
  required TextEditingController controller,
  required String hintText,
  UserController? userController,
  bool? isPassword,
  bool? isNum,
  bool? isEmail,
}) {
  if (userController != null) {
    return Obx(
      () => textField(
          controller: controller,
          hintText: hintText,
          userController: userController,
          isPassword: isPassword,
          isNum: isNum,
          isEmail: isEmail),
    );
  } else {
    return textField(
        controller: controller,
        hintText: hintText,
        userController: null,
        isPassword: isPassword,
        isNum: isNum,
        isEmail: isEmail);
  }
}

Widget textField({
  required TextEditingController controller,
  required String hintText,
  UserController? userController,
  bool? isPassword,
  bool? isNum,
  bool? isEmail,
}) {
  return TextFormField(
    controller: controller,
    style: GoogleFonts.roboto(),
    maxLines: 1,
    obscureText:
        userController != null ? userController.isObScure.value : false,
    keyboardAppearance: Brightness.dark,
    cursorOpacityAnimates: true,
    keyboardType: isEmail == true
        ? TextInputType.emailAddress
        : isNum == true
            ? TextInputType.phone
            : null,
    decoration: InputDecoration(
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
      label: Text(hintText),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 13.5.h,
      ),
      // fillColor: Colors.grey.withOpacity(.1),
      fillColor: AppColor.textFieldColor,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Color.fromRGBO(52, 228, 140, .18),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    ),
  );
}
