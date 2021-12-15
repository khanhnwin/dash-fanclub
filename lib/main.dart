import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ui/home_feed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dasher',
      theme: ThemeData(
          colorScheme: const ColorScheme(
            primary: Color.fromRGBO(0, 169, 224, 1.0),
            primaryVariant: Color.fromRGBO(0, 119, 200, 1.0),
            secondary: Color.fromRGBO(29, 79, 145, 1.0),
            secondaryVariant: Color.fromRGBO(198, 218, 231, 1.0),
            error: Color(0xb71c1cff),
            surface: Color.fromRGBO(255, 255, 255, 1.0),
            onPrimary: Color.fromRGBO(255, 255, 255, 1.0),
            background: Color.fromRGBO(198, 218, 231, 1.0),
            onSecondary: Color.fromRGBO(255, 255, 255, 1.0),
            onError: Color.fromRGBO(255, 255, 255, 1.0),
            brightness: Brightness.light,
            onBackground: Color(0x000000FF),
            onSurface: Color(0x000000FF),
          ),
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: GoogleFonts.patuaOne(
              fontSize: 28,
            ),
          )),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.blueGrey[400],
        unselectedLabelStyle: TextStyle(color: Colors.blueGrey[400]),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
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
      body: const HomeFeed(),
    );
  }
}
