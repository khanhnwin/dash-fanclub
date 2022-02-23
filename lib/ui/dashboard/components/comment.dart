import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  const Comment({required this.author, required this.commentText, Key? key})
      : super(key: key);

  final String author;
  final String commentText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: author,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  const TextSpan(text: " "),
                  TextSpan(text: commentText)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
