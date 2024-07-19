part of '../../my_tasks_screen.dart';

Widget priorityFilterSegment() {
  final list = ['High', 'Medium', 'Low'];
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Row(
            children: [
              Icon(
                Icons.flag,
                size: 22.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'Priority',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 4.h,
            ),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Checkbox.adaptive(
                    value: true,
                    visualDensity: VisualDensity.compact,
                    fillColor:
                        const WidgetStatePropertyAll(AppColor.themeGreen),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    onChanged: (value) {},
                  ),
                  Text(
                    list[index],
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}
