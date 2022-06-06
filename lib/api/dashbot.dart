import 'dart:math';
import 'chat_manager.dart';
import 'package:intl/intl.dart';

class Dashbot {
  List<String> responses = ['Hello World!', 'I am Dash!', 'I <3 Flutter'];
  List<String> jokes = [
    'The CEO of IKEA was elected Prime Minister in Sweden...\n\nHe should have his cabinet together by the end of the weekend.',
    'What\'s a pirate\'s favourite programming language? R.',
    'What do you call fake spaghetti? ... An impasta!',
  ];
  List<String> videos = [
    'https://www.youtube.com/watch?v=2Cl0C-9dK48',
    'https://www.youtube.com/watch?v=Ikg7vHJoZjA',
    'https://www.youtube.com/watch?v=sa_U0jffQII',
    'https://www.youtube.com/watch?v=8-szcYzFVao'
  ];

  Message getResponseMessage(Message input) {
    if (input.message.contains('joke')) {
      return Message(
        sender: 'Dash',
        message: jokes[Random().nextInt(jokes.length)],
      );
    } else if (input.message.contains('date')) {
      return Message(
          sender: 'Dash',
          message:
              'Today is ${DateFormat('EEEE, MMMM d').format(DateTime.now())}');
    } else if (input.message.contains('video')) {
      return Message(
          sender: 'Dash',
          message:
              'Check out this video from the Flutter channel! ${videos[Random().nextInt(videos.length)]}');
    }

    return Message(
      sender: 'Dash',
      message: responses[Random().nextInt(responses.length)],
    );
  }

  Message getFirstMessage(Message input) {
    return Message(
      sender: 'Dash',
      message: 'Hello, ${input.sender}! Nice to meet you!',
    );
  }
}
