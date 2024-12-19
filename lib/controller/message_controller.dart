import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class MessageController extends GetxController {
  final RxList<types.Message> messages = RxList<types.Message>();
  final user1 = types.User(id: 'zayn');

//====================Handle Send Pressed====================//
  void handleSendPressed(
    types.PartialText message,
  ) {
    final textMessage = types.TextMessage(
      author: user1,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: message.text,
      showStatus: true,
      status: types.Status.sent,
    );

    addMessage(textMessage);
  }

//====================Handle File Send====================//
  void handleFileSend(types.PartialFile message) {
    final fileMessage = types.FileMessage(
      author: user1,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: message.name,
      size: message.size,
      uri: message.uri,
      showStatus: true,
      status: types.Status.sent,
    );

    addMessage(fileMessage);
  }

//====================Add Message====================//
  void addMessage(types.Message message) {
    messages.insert(0, message);
  }
}
