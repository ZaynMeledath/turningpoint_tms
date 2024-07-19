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
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
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
