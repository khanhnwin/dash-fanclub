import 'dart:math';
import 'chat_manager.dart';
import 'package:intl/intl.dart';

class Dashbot {
  List<String> responses = ['Hello World!', 'I am Dash!', 'I <3 Flutter'];
  List<String> joke = [
    'The CEO of IKEA was elected Prime Minister in Sweden...\n\nHe should have his cabinet together by the end of the weekend.',
    'What\'s a pirate\'s favourite programming language? R.',
    'What do you call fake spaghetti? ... An impasta!',
  ];

  Message getResponseMessage(Message input) {
    if (input.message.contains('joke')) {
      return Message(
        sender: 'Dash',
        message: joke[Random().nextInt(joke.length)],
      );
    } else if (input.message.contains('date')) {
      return Message(
          sender: 'Dash',
          message:
              'Today is ${DateFormat('EEEE, MMMM d').format(DateTime.now())}');
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
