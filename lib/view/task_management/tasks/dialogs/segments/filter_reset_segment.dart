part of '../show_filter_bottom_sheet.dart';

Widget filterResetSegment({
  required FilterController filterController,
}) {
  return SizedBox(
    height: 50.h,
    width: 272.w,
    child: Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //--------------------Reset Filter Button--------------------//
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              filterController.resetFilters();
            },
            child: Container(
              width: 100.w,
              height: 38.h,
              margin: EdgeInsets.only(
                right: 14.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(.2),
              ),
              child: Center(
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
          //--------------------Filter Button--------------------//
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              filterController.filterTasks();
              Get.back();
            },
            child: Container(
              width: 100.w,
              height: 38.h,
              margin: EdgeInsets.only(
                right: 14.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.themeGreen,
              ),
              child: Center(
                child: Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
