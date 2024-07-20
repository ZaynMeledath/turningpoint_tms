part of '../../my_tasks_screen.dart';

Widget assignedFilterSegment({
  required TextEditingController assignedSearchController,
  required FilterController filterController,
}) {
  return Expanded(
    child: Column(
      children: [
        SizedBox(height: 8.h),
        Flexible(
          child: Transform.scale(
            scale: .94,
            child: customTextField(
              controller: assignedSearchController,
              hintText: 'Search by Name/Email',
            ),
          ),
        )
            .animate(
              key: GlobalKey(),
            )
            .slideX(
              begin: -.06,
              duration: const Duration(milliseconds: 700),
              curve: Curves.elasticOut,
            ),
        SizedBox(height: 4.h),
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            itemBuilder: (context, index) {
              final name = assignedMap.keys.elementAt(index);
              final email = assignedMap.values.elementAt(index);
              return InkWell(
                onTap: () => filterController.selectOrUnselectUsersFilter(
                    filterKey: email),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Row(
                    children: [
                      nameLetterAvatar(
                        firstName: name,
                        lastName: ' ',
                        circleDiameter: 32.w,
                      ),
                      SizedBox(width: 8.w),
                      SizedBox(
                        width: 165.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              email,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => Checkbox.adaptive(
                          value: filterController.usersFilterModel[email],
                          visualDensity: VisualDensity.compact,
                          fillColor: WidgetStatePropertyAll(
                              filterController.usersFilterModel[email] == true
                                  ? AppColor.themeGreen
                                  : Colors.transparent),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          onChanged: (value) {
                            filterController.selectOrUnselectUsersFilter(
                                filterKey: email);
                          },
                        ),
                      ),
                    ],
                  )
                      .animate(
                        key: GlobalKey(),
                      )
                      .slideX(
                        begin: -.06,
                        delay: Duration(milliseconds: 30 * (index + 1)),
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.elasticOut,
                      ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
