import 'package:flutter/material.dart';
import 'config/theme.dart';
import 'ui/dashboard/home_feed.dart';
import 'ui/shop/shop.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dasher',
      theme: myDashTheme,
      home: const MyHomePage(title: 'MyDash'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _currentWidget = HomeFeed();
  int _currentIndex = 0;

  // TODO: Implement dumb-search just check if search phrase is in the title of the product
  String _searchPhrase = "";

  void loadScreen() {
    switch (_currentIndex) {
      case 0:
        return setState(() => {_currentWidget = const HomeFeed()});
      case 1:
        return setState(() => {_currentWidget = const DashShop()});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_bag_sharp, color: Colors.white),
            onPressed: () => {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.blueGrey[400],
        unselectedLabelStyle: TextStyle(color: Colors.blueGrey[400]),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int tappedIndex) {
          setState(() => {_currentIndex = tappedIndex});
          loadScreen();
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Shop",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph_outlined),
            label: "Insights",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flutter_dash),
            label: "Detector",
          ),
        ],
      ),
      body: _currentWidget,
    );
  }
}
