part of '../../view/login/login_screen.dart';

Widget customButton({
  required String buttonTitle,
}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    width: 130,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(36, 196, 123, 1),
          Color.fromRGBO(52, 228, 140, 1)
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    child: Center(
      child: Text(
        buttonTitle,
        style: TextStyle(
          fontSize: 18,
          // fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
