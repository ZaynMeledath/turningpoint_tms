part of '../../view/login/login_screen.dart';

Widget customButton({
  required String buttonTitle,
  bool? isLoading,
}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    width: 130.w,
    height: 50.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      gradient: const LinearGradient(
        colors: [AppColor.themeGreen, Color.fromRGBO(52, 228, 140, 1)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    child: Center(
      child: isLoading == true
          ? SpinKitWave(
              color: Colors.white,
              size: 20.w,
            )
          : Text(
              buttonTitle,
              style: const TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.w500,
              ),
            ),
    ),
  );
}
