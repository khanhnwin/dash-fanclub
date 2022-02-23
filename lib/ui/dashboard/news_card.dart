import 'package:flutter/material.dart';
import 'components/comment.dart';

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

  void addComment(String comment) {
    // this would usually be the current username
    widget.postComment(widget.id, comment, "Khanh Nguyen");
  }

  void likePost() {
    setState(() {
      _liked = !_liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          PostBar(
            author: widget.author,
            authorImage: widget.authorImage,
          ),
          PostImage(doubleTap: likePost, image: widget.image),
          const Whitespace(
            height: 10,
          ),
          Caption(
            captionText: widget.content,
          ),
          const Whitespace(
            height: 10,
          ),
          Comments(
            commentData: widget.comments,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                LikeIcon(liked: _liked, doubleTap: likePost),
                CommentBox(addComment: addComment),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PostBar extends StatelessWidget {
  const PostBar({this.authorImage = "", this.author = "", Key? key})
      : super(key: key);

  final String authorImage;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
            child: authorImage != ""
                ? CircleAvatar(
                    backgroundImage: NetworkImage(authorImage),
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
              author,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () => {}),
        ],
      ),
    );
  }
}

class PostImage extends StatelessWidget {
  const PostImage({required this.doubleTap, this.image = '', Key? key})
      : super(key: key);

  final Function doubleTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 0,
      ),
      child: image != ''
          ? GestureDetector(
              onDoubleTap: () => {doubleTap()},
              child: Image(
                image: NetworkImage(image),
              ),
            )
          : const Divider(),
    );
  }
}

class Caption extends StatelessWidget {
  const Caption({required this.captionText, Key? key}) : super(key: key);

  final String captionText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Text(
        captionText,
        textAlign: TextAlign.left,
      ),
    );
  }
}

class Comments extends StatelessWidget {
  const Comments({required this.commentData, Key? key}) : super(key: key);

  final List commentData;

  @override
  Widget build(BuildContext context) {
    List<Widget> comments = [];

    for (int i = 0; i < commentData.length; i++) {
      comments.add(Comment(
        author: commentData[i]["author"],
        commentText: commentData[i]["comment"],
      ));
    }

    return Column(
      children: comments,
    );
  }
}

class LikeIcon extends StatelessWidget {
  const LikeIcon({required this.liked, required this.doubleTap, Key? key})
      : super(key: key);

  final bool liked;
  final Function doubleTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => {doubleTap()},
      icon: liked
          ? const Icon(
              Icons.favorite,
              color: Colors.red,
            )
          : const Icon(
              Icons.favorite_outline,
            ),
    );
  }
}

class CommentBox extends StatefulWidget {
  const CommentBox({required this.addComment, Key? key}) : super(key: key);

  final Function addComment;

  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
          controller: _commentController,
          decoration: InputDecoration.collapsed(
            hintText: "Add a comment...",
            hintStyle: TextStyle(color: Colors.blueGrey[400], fontSize: 14),
          ),
          onSubmitted: (String text) {
            widget.addComment(text);
            _commentController.clear();
          }),
    );
  }
}

class Whitespace extends StatelessWidget {
  const Whitespace({this.width = 0.0, this.height = 0.0, Key? key})
      : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height);
  }
}
