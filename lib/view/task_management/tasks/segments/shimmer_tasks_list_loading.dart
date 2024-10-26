import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerTasksListLoading() {
  return Shimmer.fromColors(
    baseColor: const Color.fromRGBO(90, 90, 90, .2),
    highlightColor: const Color.fromRGBO(48, 78, 85, 0.8),
    child: ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            left: 10.w,
            right: 10.w,
            bottom: 10.h,
          ),
          child: Container(
            height: 165.h,
            width: double.maxFinite,
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
