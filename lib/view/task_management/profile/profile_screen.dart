import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/utils/widgets/name_letter_avatar.dart';

part 'segments/section_title_container.dart';
part 'segments/profile_option.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context: context,
        title: 'Profile',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            children: [
              nameLetterAvatar(
                name: 'Zayn Meledath',
                circleDiameter: 80.w,
              ),
              SizedBox(height: 10.h),
              Text(
                'Zayn Meledath',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'zayn@turningpointvapi.com',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white70,
                ),
              ),
              Text(
                '+91 8289899007',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white70,
                ),
              ),
              // SizedBox(height: 6.h),
              sectionTitleContainer(title: 'Account Management'),
              profileOption(title: 'Edit Profile'),
              profileOption(title: 'Change Password'),
              sectionTitleContainer(title: 'Support'),
              profileOption(title: 'My Tickets'),
              profileOption(title: 'Raise a Ticket'),
              SizedBox(height: 40.h),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 100.w,
                    height: 46.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromRGBO(21, 25, 28, 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white38,
                          blurRadius: 1.2,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
