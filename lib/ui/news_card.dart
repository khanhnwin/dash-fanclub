import 'package:flutter/material.dart';

// ignore_for_file: avoid_print

class NewsCard extends StatefulWidget {
  const NewsCard({
    Key? key,
    required this.id,
    required this.author,
    required this.image,
    required this.content,
    required this.authorImage,
    required this.comments,
    required this.postComment,
  }) : super(key: key);

  final int id;
  final String author;
  final String image;
  final String content;
  final String authorImage;
  final List comments;
  final Function postComment;

  @override
  State<NewsCard> createState() => _NewsCard();
}

class _NewsCard extends State<NewsCard> {
  bool _liked = false;
  final TextEditingController _commentController = TextEditingController();

  Widget _comments(BuildContext context) {
    List<Widget> comments = [];

    for (int i = 0; i < widget.comments.length; i++) {
      comments.add(
        Padding(
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
                        text: widget.comments[i]["author"],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(text: " "),
                      TextSpan(text: widget.comments[i]["comment"]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: comments,
    );
  }

  void addComment(String comment) {
    widget.postComment(widget.id, comment, "Khanh Nguyen");
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
                  child: widget.authorImage != ""
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(widget.authorImage),
                          backgroundColor: Colors.lightBlue,
                          radius: 22,
                          onBackgroundImageError: (exception, context) {
                            throw ('Image Cannot be loaded');
                          },
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.brown.shade800,
                          child: const Text("IN"),
                          radius: 22,
                        ),
                ),
                Expanded(
                  child: Text(
                    widget.author,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.more_vert), onPressed: () => {}),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 0,
            ),
            child: widget.image != ""
                ? GestureDetector(
                    onDoubleTap: () => {
                      setState(() {
                        _liked = true;
                      })
                    },
                    child: Image(
                      image: NetworkImage(widget.image),
                    ),
                  )
                : const Divider(),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Text(
              widget.content,
              textAlign: TextAlign.left,
            ),
          ),
          _comments(context),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => {
                    setState(() {
                      _liked = !_liked;
                    })
                  },
                  icon: _liked
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_outline,
                        ),
                ),
                Expanded(
                  child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration.collapsed(
                        hintText: "Add a comment...",
                        hintStyle: TextStyle(
                            color: Colors.blueGrey[400], fontSize: 14),
                      ),
                      onSubmitted: (String text) => {addComment(text)}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
