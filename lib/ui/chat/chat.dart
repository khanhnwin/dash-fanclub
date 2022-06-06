import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:linkify/linkify.dart';

import '../../api/chat_manager.dart';
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

                Color backgroundColor = messages[index].sender == 'Khanh'
                    ? Color.fromARGB(255, 38, 195, 247)
                    : Color.fromARGB(255, 228, 228, 228);

                Widget textBubble = Expanded(
                  child: BubbleNormal(
                    text: message,
                    isSender: messages[index].sender == 'Khanh',
                    color: messages[index].sender == 'Khanh'
                        ? Color.fromARGB(255, 38, 195, 247)
                        : Color.fromARGB(255, 228, 228, 228),
                    tail: true,
                  ),
                );

                Widget text = Row(children: [
                  if (messages[index].sender == 'Dash')
                    SizedBox(
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/images/dash.png',
                              fit: BoxFit.cover,
                            )),
                        width: 50),
                  textBubble,
                  if (messages[index].sender != 'Dash')
                    SizedBox(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://yt3.ggpht.com/ytc/AKedOLSepRT0gjLvp3HSmlNpdM7GHfwmBj8Cegc1s0mWKQ=s900-c-k-c0x00ffffff-no-rj',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        width: 50),
                ]);

                String? link = getLink(message);

                if (link != null) {
                  Widget linkBubble = Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: AnyLinkPreview(
                      link: link,
                      displayDirection: UIDirection.uiDirectionHorizontal,
                      showMultimedia: true,
                      bodyMaxLines: 5,
                      bodyTextOverflow: TextOverflow.ellipsis,
                      titleStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  );

                  return Column(
                    children: [
                      text,
                      linkBubble,
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
