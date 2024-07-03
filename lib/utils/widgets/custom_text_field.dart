part of '../../view/login/login_screen.dart';

Widget customTextField({
  required TextEditingController controller,
  required String hintText,
  IconData? suffixIcon,
  bool? obscureText,
}) {
  return TextFormField(
    controller: controller,
    style: GoogleFonts.roboto(),
    maxLines: 1,
    obscureText: obscureText ?? false,
    keyboardAppearance: Brightness.dark,
    cursorOpacityAnimates: true,
    decoration: InputDecoration(
      suffixIcon: Icon(suffixIcon),
      label: Text(hintText),
      contentPadding: EdgeInsets.symmetric(
        horizontal: screenWidth * .034,
        vertical: screenHeight * .015,
      ),
      fillColor: Colors.grey.withOpacity(.1),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
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
