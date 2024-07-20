part of '../../my_tasks_screen.dart';

Widget categoryFilterSegment({
  required TextEditingController categorySearchController,
}) {
  final list = ['Marketing', 'Sales', 'HR/Admin'];
  return Expanded(
    child: Column(
      children: [
        SizedBox(height: 8.h),
        Flexible(
          child: Transform.scale(
            scale: .94,
            child: customTextField(
              controller: categorySearchController,
              hintText: 'Search Category',
            ).animate().slideY(
                  begin: .5,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.elasticOut,
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
              ).animate().slideY(
                    begin: .5,
                    delay: Duration(milliseconds: 40 * (index + 1)),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.elasticOut,
                  );
            },
          ),
        ),
      ],
    ),
  );
}
