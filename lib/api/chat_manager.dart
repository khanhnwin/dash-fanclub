import 'dashbot.dart';

Dashbot dash = Dashbot();

class ChatManager {
  final List<Message> messages = [];

  void newMessage(Message message) {
    messages.add(message);
  }

  void getResponse(Message message) {
    if (messages.length > 1) {
      messages.add(dash.getResponseMessage(message));
    } else {
      messages.add(dash.getFirstMessage(message));
    }
  }
}

class Message {
  String sender;
  String message;

  Message({required this.sender, required this.message});
}
