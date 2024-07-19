part of '../../my_tasks_screen.dart';

Widget assignedFilterSegment({
  required TextEditingController assignedSearchController,
}) {
  final map = {
    'Zayn': 'zayn@turningpointvapi.com',
    'Ajay': 'ajay@turningpointvapi.com',
    'Tanya': 'tanya@turningpointvapi.com',
  };

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
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Row(
                  children: [
                    nameLetterAvatar(
                      firstName: map.keys.elementAt(index),
                      lastName: ' ',
                      circleDiameter: 32.w,
                    ),
                    SizedBox(width: 8.w),
                    SizedBox(
                      width: 170.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            map.keys.elementAt(index),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            map.values.elementAt(index),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
