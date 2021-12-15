import 'package:flutter/material.dart';
import '../api/dash_updates.dart';

class NoDashUpdates extends StatelessWidget {
  const NoDashUpdates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Text(
          'No new updates from Dash!',
        ),
        Padding(
            padding: EdgeInsets.all(0),
            child: Image(image: AssetImage('assets/images/dash.png'))),
      ],
    );
  }
}

DashUpdates dashUpdater = DashUpdates();
String authorName = "Khanh Nguyen";

class NewsCard extends StatefulWidget {
  const NewsCard(
      {Key? key,
      required this.id,
      required this.author,
      required this.image,
      required this.content,
      required this.authorImage,
      required this.comments})
      : super(key: key);

  final int id;
  final String author;
  final String image;
  final String content;
  final String authorImage;
  final List comments;

  @override
  State<NewsCard> createState() => _NewsCard();
}

class _NewsCard extends State<NewsCard> {
  bool _liked = false;

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
                            print('Image Cannot be loaded');
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
                      decoration: InputDecoration.collapsed(
                        hintText: "Add a comment...",
                        hintStyle: TextStyle(
                            color: Colors.blueGrey[400], fontSize: 14),
                      ),
                      onSubmitted: (String text) => {
                            //dashUpdater.addComment(widget.id, text, authorName)
                          }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeFeed extends StatefulWidget {
  const HomeFeed({Key? key}) : super(key: key);

  @override
  State<HomeFeed> createState() => _HomeFeed();
}

class _HomeFeed extends State<HomeFeed> {
  List _dashUpdates = [];
  bool dashUpdatesAvailable = true;

  @override
  void initState() {
    _dashUpdates = dashUpdater.getUpdates();
  }

  Widget dashUpdates() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _dashUpdates.length,
        itemBuilder: (BuildContext context, int index) {
          if (_dashUpdates[index]["id"] != null) {
            return NewsCard(
                id: _dashUpdates[index]["id"],
                author: _dashUpdates[index]["author"],
                image: _dashUpdates[index]["image"],
                content: _dashUpdates[index]["content"],
                authorImage: _dashUpdates[index]["authorImage"],
                comments: _dashUpdates[index]["comments"]);
          } else {
            return const Divider();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: dashUpdatesAvailable ? dashUpdates() : const NoDashUpdates());
  }
}
