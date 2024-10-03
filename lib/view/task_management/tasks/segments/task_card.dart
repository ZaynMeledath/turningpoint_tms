import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/extensions/string_extensions.dart';
import 'package:turning_point_tasks_app/view/task_management/assign_task/assign_task_screen.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/card_action_button.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/task_crud_operations.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/task_details_screen.dart';

Widget taskCard({
  required AnimationController lottieController,
  required TaskModel taskModel,
  required TasksController tasksController,
  bool? isAllTasks,
}) {
  Color priorityFlagColor = Colors.white.withOpacity(.9);

  final isTaskCompleted = taskModel.status == Status.completed;

  switch (taskModel.priority) {
    case 'High':
      priorityFlagColor = Colors.red;
      break;
    case 'Medium':
      priorityFlagColor = Colors.orange;
      break;
    default:
      break;
  }

  final dueDateString = '${taskModel.dueDate?.dateFormat()}';
  final user = getUserModelFromHive();

  return Hero(
    tag: 'task_card${taskModel.id}',
    child: Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          Get.to(
            () => TaskDetailsScreen(
              taskModel: taskModel,
              dueDateString: dueDateString,
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(48, 78, 85, 0.6),
                Color.fromRGBO(29, 36, 41, 1),
                Color.fromRGBO(90, 90, 90, .5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 13.5.w,
              vertical: 10.h,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    //--------------------Name and details column--------------------//
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 192.w,
                          child: Text(
                            taskModel.title.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.w),
                        SizedBox(
                          width: 192.w,
                          child: Text.rich(
                            overflow: TextOverflow.ellipsis,
                            TextSpan(
                              text: tasksController.isDelegatedObs.value == true
                                  ? 'Assigned To '
                                  : 'Assigned By ',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.6),
                              ),
                              children: [
                                TextSpan(
                                  text: tasksController.isDelegatedObs.value ==
                                          true
                                      ? '${taskModel.assignedTo?.first.name}'
                                          .nameFormat()
                                      : '${taskModel.createdBy?.name!.nameFormat()}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            isAllTasks == true
                                ? Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 19.sp,
                                        color: Colors.white70,
                                      ),
                                      SizedBox(width: 2.w),
                                      Text(
                                        taskModel.assignedTo!.first.name!,
                                        style: TextStyle(
                                          fontSize: 13.5.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                    ],
                                  )
                                : const SizedBox(),
                            Icon(
                              Icons.sell,
                              size: 16.sp,
                              color: Colors.white70,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              taskModel.category.toString(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 14.w),
                            Icon(
                              Icons.flag,
                              size: 17.sp,
                              color: priorityFlagColor,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              taskModel.priority.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.alarm,
                              size: 17.sp,
                              color: Colors.white70,
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              dueDateString,
                              style: TextStyle(
                                color: taskModel.isDelayed == true
                                    ? Colors.red
                                    : Colors.green,
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Lottie.asset(
                          'assets/lotties/task_${taskModel.status}_animation.json',
                          controller: lottieController,
                          width: 30.sp,
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          taskModel.status.toString(),
                          style: TextStyle(
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                isTaskCompleted &&
                        (tasksController.isDelegatedObs.value == true ||
                            user?.role == Role.admin)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          cardActionButton(
                            title: 'Delete',
                            icon: Icons.delete,
                            iconColor: Colors.red,
                            onTap: () => TaskCrudOperations.deleteTask(
                              tasksController: tasksController,
                              taskModel: taskModel,
                            ),
                          ),
                          cardActionButton(
                            title: 'Re Open',
                            icon: StatusIcons.inProgress,
                            iconColor: StatusColor.open,
                            onTap: () => TaskCrudOperations.updateTaskStatus(
                              taskId: taskModel.id.toString(),
                              taskStatus: Status.open,
                              tasksController: tasksController,
                            ),
                          ),
                        ],
                      )
                    : !isTaskCompleted
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              cardActionButton(
                                title: 'In Progress',
                                icon: StatusIcons.inProgress,
                                iconColor: StatusColor.inProgress,
                                onTap: () =>
                                    TaskCrudOperations.updateTaskStatus(
                                  taskId: taskModel.id.toString(),
                                  taskStatus: Status.inProgress,
                                  tasksController: tasksController,
                                ),
                              ),
                              cardActionButton(
                                title: 'Completed',
                                icon: StatusIcons.completed,
                                iconColor: StatusColor.completed,
                                onTap: () =>
                                    TaskCrudOperations.updateTaskStatus(
                                  taskId: taskModel.id.toString(),
                                  taskStatus: Status.completed,
                                  tasksController: tasksController,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                SizedBox(height: isTaskCompleted ? 0 : 9.h),
                !isTaskCompleted &&
                        (tasksController.isDelegatedObs.value == true ||
                            user?.role == Role.admin)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          cardActionButton(
                            title: 'Edit',
                            icon: Icons.edit,
                            iconColor: Colors.blueGrey,
                            onTap: () => Get.to(
                              () => AssignTaskScreen(
                                taskModel: taskModel,
                              ),
                              transition: Transition.downToUp,
                            ),
                          ),
                          cardActionButton(
                            title: 'Delete',
                            icon: Icons.delete,
                            iconColor: Colors.red,
                            onTap: () => TaskCrudOperations.deleteTask(
                              tasksController: tasksController,
                              taskModel: taskModel,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
