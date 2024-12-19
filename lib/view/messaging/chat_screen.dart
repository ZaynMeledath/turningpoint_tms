import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/message_controller.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:turningpoint_tms/view/messaging/segments/custom_bottom_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final user1 = types.User(id: 'zayn');
  final user2 = types.User(id: 'hari');

  final messageController = Get.put(MessageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        title: 'Hari Krishna',
      ),
      body: Obx(
        () {
          final List<types.Message> messages = messageController.messages.value;
          return Chat(
            messages: messages,
            scrollPhysics: BouncingScrollPhysics(),
            onSendPressed: (types.PartialText message) {},
            // onAttachmentPressed: () {},
            slidableMessageBuilder: _buildSlidableMessageBuilder,
            user: user1,
            customBottomWidget: CustomBottomWidget(),
            theme: DarkChatTheme(
              backgroundColor: AppColors.scaffoldBackgroundColor,
              // attachmentButtonIcon: ,
              // attachmentButtonMargin: EdgeInsets.zero,
              inputBackgroundColor: AppColors.textFieldColor,
              inputBorderRadius: BorderRadius.circular(16),
              // inputMargin: EdgeInsets.only(
              //   left: 12.w,
              //   right: 12.w,
              //   bottom: 14.h,
              //   top: 2.h,
              // ),
              inputPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 14.w,
              ),
              primaryColor: AppColors.themeGreen,
              secondaryColor: Color.fromRGBO(51, 58, 62, 1),
            ),
          );
        },
      ),
    );
  }

//====================Slidable Message Builder====================//
  Widget _buildSlidableMessageBuilder(message, msgWidget) {
    final createdAt = DateTime.fromMillisecondsSinceEpoch(message.createdAt!);
    final createdTimeString =
        '${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}';
    return Slidable(
      closeOnScroll: true,
      key: ValueKey(message.id), // Unique key for the message
      startActionPane: message.author != user1
          ? ActionPane(
              motion: DrawerMotion(),
              extentRatio: .20,
              children: [
                SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: AppColors.scaffoldBackgroundColor,
                  foregroundColor: Colors.white,
                  label: createdTimeString,
                ),
              ],
            )
          : null,
      endActionPane: message.author == user1
          ? ActionPane(
              motion: DrawerMotion(),
              extentRatio: .20,
              children: [
                SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: AppColors.scaffoldBackgroundColor,
                  foregroundColor: Colors.white,
                  label: createdTimeString,
                ),
              ],
            )
          : null,
      child: msgWidget,
    );
  }
}
