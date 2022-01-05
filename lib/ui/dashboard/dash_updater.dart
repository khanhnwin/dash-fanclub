import 'package:flutter/material.dart';
import '../../api/dash_updates.dart';
import './news_card.dart';

// ignore_for_file: avoid_print

class DashUpdater extends StatefulWidget {
  const DashUpdater({Key? key}) : super(key: key);

  @override
  State<DashUpdater> createState() => _DashUpdater();
}

class _DashUpdater extends State<DashUpdater> {
  final DashUpdates dashUpdater = DashUpdates();
  List _dashUpdates = [];

  @override
  initState() {
    super.initState();
    _dashUpdates = dashUpdater.getUpdates();
  }

  void postComment(int postId, String comment, String author) {
    setState(() {
      _dashUpdates = dashUpdater.addComment(postId, comment, author);
      print(_dashUpdates);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _dashUpdates.length,
        itemBuilder: (BuildContext context, int index) {
          return NewsCard(
            id: _dashUpdates[index]["id"],
            author: _dashUpdates[index]["author"],
            image: _dashUpdates[index]["image"],
            content: _dashUpdates[index]["content"],
            authorImage: _dashUpdates[index]["authorImage"],
            comments: _dashUpdates[index]["comments"],
            postComment: postComment,
          );
        });
  }
}
