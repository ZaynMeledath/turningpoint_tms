import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/constants/tasks_management_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/tickets_controller.dart';
import 'package:turningpoint_tms/model/tickets_model.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
import 'package:turningpoint_tms/utils/widgets/server_error_widget.dart';
import 'package:turningpoint_tms/view/task_management/home/tasks_dashboard.dart';

class MyTicketsScreen extends StatefulWidget {
  const MyTicketsScreen({super.key});

  @override
  State<MyTicketsScreen> createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends State<MyTicketsScreen> {
  final ticketsController = TicketsController();
  final appController = AppController();

  @override
  void initState() {
    ticketsController.getMyTickets();
    super.initState();
  }

  @override
  void dispose() {
    appController.dispose();
    ticketsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'My Tickets'),
      body: Obx(
        () {
          List<TicketModel>? ticketsList = ticketsController.myTickets.value;

          if (ticketsController.ticketsException.value != null) {
            return Center(
              child: serverErrorWidget(
                onRefresh: () async {
                  appController.isLoadingObs.value = true;
                  await ticketsController.getMyTickets();
                  appController.isLoadingObs.value = false;
                },
                isLoading: appController.isLoadingObs.value,
              ),
            );
          }

          if (ticketsList != null && ticketsList.isNotEmpty) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 5.h,
              ),
              itemCount: ticketsList.length,
              itemBuilder: (context, index) {
                final ticket = ticketsList[index];
                Color statusColor = StatusColor.open;
                switch (ticket.status) {
                  case TicketStatus.open:
                    statusColor = StatusColor.open;
                    break;
                  case TicketStatus.inProgress:
                    statusColor = StatusColor.inProgress;
                    break;
                  case TicketStatus.resolved:
                    statusColor = AppColors.themeGreen;
                    break;
                  case TicketStatus.closed:
                    statusColor = StatusColor.overdue;
                    break;
                  default:
                    break;
                }
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  margin: EdgeInsets.only(bottom: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(48, 78, 85, .4),
                        Color.fromRGBO(29, 36, 41, 1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: Colors.grey.withOpacity(.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              ticket.title.toString(),
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            ticket.status.toString(),
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.h),
                      Container(
                        height: 1,
                        color: Colors.white12,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        ticket.description.toString(),
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 5.h,
              ),
              child: shimmerListLoading(
                containerHeight: 100.h,
                containerCount: 8,
              ),
            );
          }
        },
      ),
    );
  }
}
