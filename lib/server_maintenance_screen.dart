import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';

class ServerMaintenanceScreen extends StatelessWidget {
  const ServerMaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Server Maintenance'),
      body: Column(
        children: [
          Lottie.asset(
            'assets/lotties/server_error_animation.json',
            width: 200.w,
          ),
          Text(
            'Server Maintenance Ongoing',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
