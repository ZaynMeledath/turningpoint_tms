part of '../assign_task_screen.dart';

Widget assignToAndCategorySegment({
  required TasksController tasksController,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
//====================Assign To Dropdown====================//
      SizedBox(
        width: screenWidth * .38,
        child: DropdownButtonFormField(
          elevation: 2,
          hint: Text(
            'Assign to',
            style: TextStyle(
              fontSize: screenWidth * .039,
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
          items: const [
            DropdownMenuItem(
              value: RepeatFrequency.daily,
              child: Text('Daily'),
            ),
            DropdownMenuItem(
              value: RepeatFrequency.weekly,
              child: Text('Weekly'),
            ),
            DropdownMenuItem(
              value: RepeatFrequency.monthly,
              child: Text('Monthly'),
            ),
          ],
          onChanged: tasksController.repeatFrequencyOnChanged,
        ),
      ),

//====================Task Category Dropdown====================//
      SizedBox(
        width: screenWidth * .38,
        child: DropdownButtonFormField(
          elevation: 2,
          hint: Text(
            'Category',
            style: TextStyle(
              fontSize: screenWidth * .039,
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
          items: const [
            DropdownMenuItem(
              value: RepeatFrequency.daily,
              child: Text('Daily'),
            ),
            DropdownMenuItem(
              value: RepeatFrequency.weekly,
              child: Text('Weekly'),
            ),
            DropdownMenuItem(
              value: RepeatFrequency.monthly,
              child: Text('Monthly'),
            ),
          ],
          onChanged: tasksController.repeatFrequencyOnChanged,
        ),
      ),
    ],
  );
}
