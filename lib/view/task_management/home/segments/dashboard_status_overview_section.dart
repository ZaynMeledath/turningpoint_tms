part of '../tasks_dashboard.dart';

Widget dashboardStatusOverviewSection() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          dashboardStatusOverviewContainer(
            status: Status.overdue,
            count: 8,
            icon: StatusIcons.overdue,
            iconColor: Colors.red,
          ),
          dashboardStatusOverviewContainer(
            status: Status.pending,
            count: 8,
            icon: StatusIcons.pending,
            iconColor: Colors.orange,
          ),
          dashboardStatusOverviewContainer(
            status: Status.inProgress,
            count: 8,
            icon: StatusIcons.inProgress,
            iconColor: Colors.blue,
          ),
        ],
      ),
      SizedBox(height: 10.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          dashboardStatusOverviewContainer(
            status: Status.completed,
            count: 8,
            icon: StatusIcons.completed,
            iconColor: AppColor.themeGreen,
          ),
          dashboardStatusOverviewContainer(
            status: 'In Time',
            count: 8,
            icon: Icons.schedule,
            iconColor: AppColor.themeGreen,
          ),
          dashboardStatusOverviewContainer(
            status: 'Delayed',
            count: 8,
            icon: Icons.schedule,
            iconColor: Colors.red,
          ),
        ],
      ),
    ],
  );
}
