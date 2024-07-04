part of '../../view/login/login_screen.dart';

typedef SuffixFunction = void Function();

Widget customTextField({
  required TextEditingController controller,
  required String hintText,
  required UserController userController,
  bool? isPassword,
  bool? isNum,
  bool? isEmail,
}) {
  return Obx(
    () => TextFormField(
      controller: controller,
      style: GoogleFonts.roboto(),
      maxLines: 1,
      obscureText: userController.isObScure.value,
      keyboardAppearance: Brightness.dark,
      cursorOpacityAnimates: true,
      keyboardType: isEmail == true
          ? TextInputType.emailAddress
          : isNum == true
              ? TextInputType.phone
              : null,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            isPassword == true
                ? userController.isObScure.value == true
                    ? Icons.visibility_off
                    : Icons.visibility
                : null,
          ),
          onPressed: () {
            if (isPassword == true) {
              userController.isObScure.value = !userController.isObScure.value;
            }
          },
        ),
        label: Text(hintText),
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * .034,
          vertical: screenHeight * .015,
        ),
        fillColor: Colors.grey.withOpacity(.1),
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
    ),
  );
}
