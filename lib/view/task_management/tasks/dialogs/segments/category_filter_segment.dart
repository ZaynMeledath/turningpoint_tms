import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/filter_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/view/login/login_screen.dart';

Widget categoryFilterSegment({
  required TextEditingController categorySearchController,
  required FilterController filterController,
  required TasksController tasksController,
  required int animationFlag,
}) {
  bool shouldAnimate = animationFlag < 1;
  final appController = AppController();
  return Expanded(
    child: tasksController.categoriesList.isNotEmpty
        ? Column(
            children: [
              SizedBox(height: 8.h),
              Transform.scale(
                scale: .94,
                child: customTextField(
                    controller: categorySearchController,
                    hintText: 'Search Category',
                    onChanged: (value) {
                      filterController.categoriesSearchList.clear();
                      filterController.categoriesSearchList.value =
                          tasksController.categoriesList
                              .where((category) => category
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                    }),
              ),
              // .animate(
              //   key: GlobalKey(),
              // )
              // .slideX(
              //   begin: -.06,
              //   duration: const Duration(milliseconds: 700),
              //   curve: Curves.elasticOut,
              // ),
              Expanded(
                child: ListView.builder(
                  itemCount: filterController.categoriesSearchList.isEmpty &&
                          categorySearchController.text.trim().isEmpty
                      ? tasksController.categoriesList.length
                      : filterController.categoriesSearchList.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  itemBuilder: (context, index) {
                    final category =
                        filterController.categoriesSearchList.isEmpty &&
                                categorySearchController.text.trim().isEmpty
                            ? tasksController.categoriesList[index]
                            : filterController.categoriesSearchList[index];
                    return InkWell(
                      enableFeedback: true,
                      onTap: () {
                        filterController.selectOrUnselectCategoryFilter(
                            filterKey: category);
                      },
                      child: Row(
                        children: [
                          Obx(
                            () => Checkbox.adaptive(
                              value: filterController
                                      .categoryFilterModel[category] ??
                                  false,
                              visualDensity: VisualDensity.compact,
                              fillColor: WidgetStatePropertyAll(filterController
                                          .categoryFilterModel[category] ==
                                      true
                                  ? AppColors.themeGreen
                                  : Colors.transparent),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              onChanged: (value) => filterController
                                  .selectOrUnselectCategoryFilter(
                                      filterKey: category),
                            ),
                          ),
                          Text(
                            category,
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      )
                          .animate(
                            key: GlobalKey(),
                          )
                          .slideX(
                            begin: shouldAnimate ? -.06 : 0,
                            delay: Duration(milliseconds: 30 * (index + 1)),
                            duration: const Duration(milliseconds: 700),
                            curve: shouldAnimate
                                ? Curves.elasticOut
                                : Curves.linear,
                          ),
                    );
                  },
                ),
              ),
            ],
          )
        : Column(
            children: [
              SizedBox(height: 120.h),
              Lottie.asset(
                'assets/lotties/empty_list_animation.json',
                width: 100.w,
              ),
              Obx(
                () => customButton(
                  buttonTitle: 'Reload Categories',
                  fontSize: 14.sp,
                  onTap: () async {
                    appController.isLoadingObs.value = true;
                    await tasksController.getCategories();
                    appController.isLoadingObs.value = false;
                  },
                  isLoading: appController.isLoadingObs.value,
                ),
              ),
            ],
          ),
  );
}
