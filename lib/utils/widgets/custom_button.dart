part of '../../view/login/login_screen.dart';

Widget customButton({
  required String buttonTitle,
  required void Function() onTap,
  double? width,
  double? height,
  double? fontSize,
  BorderRadius? borderRadius,
  EdgeInsetsGeometry? buttonPadding,
  bool? isLoading,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: borderRadius ?? BorderRadius.circular(30),
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 10.h,
              ),
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.themeGreen,
                    Color.fromRGBO(52, 228, 140, 1),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Center(
                child: isLoading == true
                    ? SpinKitWave(
                        color: Colors.white,
                        size: 18.w,
                      )
                    : Text(
                        buttonTitle,
                        style: TextStyle(
                          fontSize: fontSize ?? 18.w,
                          // fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
