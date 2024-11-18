import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';

class ProfilePictureViewScreen extends StatelessWidget {
  const ProfilePictureViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final pictureSize = screenSize.width;

    return Scaffold(
      appBar: myAppBar(
        title: 'Profile Picture',
        trailingIcons: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Edit',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.lightBlueAccent,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 155.h),
          CachedNetworkImage(
            imageUrl: '',
            width: pictureSize,
            height: pictureSize,
          ),
        ],
      ),
    );
  }
}
