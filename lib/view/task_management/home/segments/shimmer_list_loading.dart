part of '../tasks_dashboard.dart';

Widget shimmerListLoading({
  double? containerHeight,
  int? containerCount,
}) {
  return Shimmer.fromColors(
    baseColor: const Color.fromRGBO(90, 90, 90, .2),
    highlightColor: const Color.fromRGBO(48, 78, 85, 0.8),
    child: ListView.builder(
      itemCount: containerCount ?? 5,
      padding: EdgeInsets.only(
        top: 8.h,
        bottom: 60.h,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: 10.h,
          ),
          child: Container(
            width: double.maxFinite,
            height: containerHeight ?? 120.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(48, 78, 85, 0.6),
                  Color.fromRGBO(29, 36, 41, 1),
                  Color.fromRGBO(90, 90, 90, .5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        );
      },
    ),
  );
}
