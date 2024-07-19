part of '../assign_task_screen.dart';

Widget assignToAndCategorySegment({
  required TasksController tasksController,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
//====================Assign To Dropdown====================//
      SizedBox(
        width: 156.w,
        child: DropdownButtonFormField(
          elevation: 2,
          isExpanded: true,
          hint: Text(
            'Assign to',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white70,
            ),
          ),
          value: tasksController.taskRepeatFrequency.value,
          borderRadius: BorderRadius.circular(20),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.withOpacity(.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
          items: [
            DropdownMenuItem(
              value: RepeatFrequency.daily,
              child: Text(
                'Daily',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ),
            DropdownMenuItem(
              value: RepeatFrequency.weekly,
              child: Text(
                'Weekly',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ),
            DropdownMenuItem(
              value: RepeatFrequency.monthly,
              child: Text(
                'Monthly',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
          onChanged: tasksController.repeatFrequencyOnChanged,
        ),
      ),

//====================Task Category Dropdown====================//
      SizedBox(
        width: 156.w,
        child: DropdownButtonFormField(
          elevation: 2,
          isExpanded: true,
          hint: Text(
            'Category',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white70,
            ),
          ),
          value: tasksController.taskRepeatFrequency.value,
          borderRadius: BorderRadius.circular(20),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.withOpacity(.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
          items: [
            DropdownMenuItem(
              value: RepeatFrequency.daily,
              child: Text(
                'Daily',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ),
            DropdownMenuItem(
              value: RepeatFrequency.weekly,
              child: Text(
                'Weekly',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ),
            DropdownMenuItem(
              value: RepeatFrequency.monthly,
              child: Text(
                'Monthly',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
          onChanged: tasksController.repeatFrequencyOnChanged,
        ),
      ),
    ],
  );
}
