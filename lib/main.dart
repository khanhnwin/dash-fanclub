import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'Dasher'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List _dashUpdates = [
    {
      "author": "Dash the Flutter Mascot",
      "image": "https://flutter.dev/assets/images/dash/dash-fainting.gif",
      "content":
          "Hey y'all, this is Dash here! I'm finally back from vacation and ready to get Fluttering again!",
      "authorImage": "https://flutter.dev/assets/images/dash/Dash.png",
    },
    {
      "author": "Khanh Nguyen",
      "image":
          "https://flutter.dev/assets/images/dash/dash-conference-swag.jpg",
      "content":
          "Y'all, I've found the Dash plushie warehouse. No one tell Shams that I'm here...",
      "authorImage":
          "https://yt3.ggpht.com/ytc/AKedOLSepRT0gjLvp3HSmlNpdM7GHfwmBj8Cegc1s0mWKQ=s176-c-k-c0x00ffffff-no-rj",
    },
    {
      "author": "Shams Zakhour",
      "image": "https://flutter.dev/assets/images/dash/ShamsDashJacket.png",
      "content": "Check out my new Dash-inspired jean jacket! - Shams."
    },
  ];

  bool dashUpdatesAvailable = true;

  Widget dashUpdates() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _dashUpdates.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _dashUpdates[index]["authorImage"] != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                                _dashUpdates[index]["authorImage"]),
                            backgroundColor: Colors.lightBlue,
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.brown.shade800,
                            child: const Text("SZ"),
                          ),
                  ),
                  Text(
                    _dashUpdates[index]["author"],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.all(4)),
              Text(_dashUpdates[index]["content"]),
              const Padding(padding: EdgeInsets.all(8)),
              Image(image: NetworkImage(_dashUpdates[index]["image"])),
              const Padding(padding: EdgeInsets.all(16), child: Divider()),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: const [
          DrawerHeader(
            child: Text('Drawer Header'),
          )
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.blueGrey[400],
        unselectedLabelStyle: TextStyle(color: Colors.blueGrey[400]),
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: dashUpdatesAvailable
            ? dashUpdates()
            : Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    'No new updates from Dash!',
                  ),
                  Padding(
                      padding: EdgeInsets.all(0),
                      child:
                          Image(image: AssetImage('assets/images/dash.png'))),
                ],
              ),
      ),
    );
  }
}
