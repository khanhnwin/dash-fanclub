import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:dash_fanclub_app/ui/chat/bubbles.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:linkify/linkify.dart';

import '../../api/chat_manager.dart';
import './link_preview_bubble.dart';
import 'dart:async';
import 'dart:math';

GetIt getIt = GetIt.instance;

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();
  List<Message> messages = getIt<ChatManager>().messages;

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  String? getLink(String input) {
    List<LinkifyElement> links = linkify(input);

    for (LinkifyElement element in links) {
      if (element is LinkableElement) {
        return element.url;
      }
    }

    return null;
  }

  void getMessages() {
    setState(() {
      messages = getIt<ChatManager>().messages;
    });

    scrollToBottom();
  }

  void onSend() {
    String inputText = controller.text.trim();
    if (inputText != '') {
      Message inputMessage = Message(sender: 'Khanh', message: inputText);

      getIt<ChatManager>().newMessage(inputMessage);

      controller.clear();

      getMessages();

      Duration fakeNetworkDelay =
          Duration(milliseconds: (Random().nextInt(26) * 100) + 500);

      Timer(fakeNetworkDelay, () {
        getIt<ChatManager>().getResponse(inputMessage);
        getMessages();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        Expanded(
          child: ListView.builder(
              controller: scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                String message = messages[index].message;

                Widget text = messages[index].sender == 'Dash'
                    ? DashBubble(message: message)
                    : UserBubble(
                        message: message,
                        userImage:
                            'https://yt3.ggpht.com/ytc/AKedOLSepRT0gjLvp3HSmlNpdM7GHfwmBj8Cegc1s0mWKQ=s900-c-k-c0x00ffffff-no-rj');

                String? link = getLink(message);

                if (link != null) {
                  return Column(
                    children: [
                      text,
                      LinkBubble(link: link),
                    ],
                  );
                }

                return text;
              }),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Start typing',
            suffixIcon: GestureDetector(
              child: Icon(Icons.send),
              onTap: onSend,
            ),
          ),
        ),
      ]),
    );
  }
}
