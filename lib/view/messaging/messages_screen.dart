import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
import 'package:turningpoint_tms/utils/widgets/name_letter_avatar.dart';
import 'package:turningpoint_tms/view/messaging/chat_screen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        title: 'Messages',
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: nameLetterAvatar(name: 'Hari Krishna'),
            title: Text(
              'Hari Krishna',
              style: TextStyle(
                fontSize: 18.w,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'Hello There!',
              style: TextStyle(
                fontSize: 14.w,
              ),
            ),
            splashColor: Colors.blueGrey.withOpacity(.1),
            shape: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(.1),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.w,
            ),
            onTap: () {
              Get.to(
                () => ChatScreen(),
                transition: Transition.rightToLeft,
              );
            },
          );
        },
      ),
    );
  }
}
