part of '../my_tasks_screen.dart';

Future<Object?> showFilterBottomSheet({
  required TextEditingController categorySearchController,
  required TextEditingController assignedSearchController,
}) async {
  return Get.bottomSheet(
    Container(
      height: 480.h,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(29, 36, 41, 1),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
              child: Text(
                'Filter Task',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 1,
            color: Colors.grey.withOpacity(.1),
          ),
          Expanded(
            child: Row(
              children: [
//--------------------Filter Key Part--------------------//
                Container(
                  width: 120.w,
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.15),
                  ),
                  child: Column(
                    children: [
                      filterItem(
                        title: 'Category',
                        isActive: true,
                      ),
                      SizedBox(height: 6.h),
                      filterItem(
                        title: 'Assigned By',
                        isActive: false,
                      ),
                      SizedBox(height: 6.h),
                      filterItem(
                        title: 'Frequency',
                        isActive: false,
                      ),
                      SizedBox(height: 6.h),
                      filterItem(
                        title: 'Priority',
                        isActive: false,
                      ),
                    ],
                  ),
                ),
//--------------------Filter Value Part--------------------//
                // categoryFilterSegment(
                //   categorySearchController: categorySearchController,
                // ),

                // assignedFilterSegment(
                //     assignedSearchController: assignedSearchController,),

                // frequencyFilterSegment(),

                priorityFilterSegment(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
