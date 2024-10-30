import 'package:flutter/widgets.dart' show Widget;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';

Widget customRefreshIndicator({
  required Future<void> Function() onRefresh,
  required Widget child,
}) {
  return LiquidPullToRefresh(
    onRefresh: onRefresh,
    showChildOpacityTransition: false,
    color: AppColors.scaffoldBackgroundColor,
    height: 65.w,
    springAnimationDurationInMilliseconds: 400,
    backgroundColor: AppColors.themeGreen,
    child: child,
  );
}
