import 'package:flutter/material.dart';
import './dash_updater.dart';
import 'dart:async';

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

class HomeFeed extends StatefulWidget {
  const HomeFeed({Key? key}) : super(key: key);

  @override
  State<HomeFeed> createState() => _HomeFeed();
}

class _HomeFeed extends State<HomeFeed> {
  bool dashUpdatesAvailable = false;

  @override
  initState() {
    super.initState();

    fakeFetchData();
  }

  void fakeFetchData() {
    const fakeNetworkDelay = Duration(milliseconds: 1000);

    Timer(
        fakeNetworkDelay,
        () => {
              setState(() {
                dashUpdatesAvailable = true;
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            dashUpdatesAvailable ? const DashUpdater() : const NoDashUpdates());
  }
}
