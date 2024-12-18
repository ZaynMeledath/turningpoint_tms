import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/controller/message_controller.dart';

class CustomBottomWidget extends StatefulWidget {
  const CustomBottomWidget({super.key});

  @override
  State<CustomBottomWidget> createState() => _CustomBottomWidgetState();
}

class _CustomBottomWidgetState extends State<CustomBottomWidget> {
  final messageController = Get.put(MessageController());
  final user1 = types.User(id: 'zayn');
  final user2 = types.User(id: 'hari');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 12.w,
        right: 2.w,
        bottom: 14.h,
        top: 2.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Input(
              onSendPressed: _handleSendPressed,
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {},
            icon: Icon(
              Icons.photo_outlined,
              size: 25.w,
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {},
            icon: Icon(
              Icons.camera_alt_outlined,
              size: 25.w,
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {},
            icon: Icon(
              Icons.mic,
              size: 25.w,
            ),
          ),
        ],
      ),
    );
  }

  void _handleSendPressed(
    types.PartialText message,
  ) {
    final textMessage = types.TextMessage(
      author: user2,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: message.text,
      showStatus: true,
      status: types.Status.delivered,
    );

    _addMessage(textMessage);
  }

  void _addMessage(types.Message message) {
    messageController.messages.insert(0, message);
  }
}
