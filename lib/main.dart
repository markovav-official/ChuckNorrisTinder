import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'cards.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = "Chuck Norris Tinder";

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Pagination(key: key, title: title), //Scaffold(
      //   appBar: AppBar(
      //     title: const Text(title),
      //   ),
      //   body: ,
      // ),
    );
  }
}

class Pagination extends StatefulWidget {
  const Pagination({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  var currentIndex = 0;
  final pages = const <Widget>[
    SafeArea(
      child: Center(
        child: Cards(),
      ),
    ),
    TabPage(
      title: 'Tab No2',
      key: ValueKey(2),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: pages[currentIndex],
      // body: IndexedStack(
      //   children: pages,
      //   index: currentIndex,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index != currentIndex) {
            setState(() {
              currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.emoji_emotions_outlined),
            label: 'Jokes',
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.star_outline),
            label: 'Favorite',
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}

class TabPage extends StatefulWidget {
  const TabPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headline5,
          ),
          Text('Current count $count'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
            child: const Text('Increment'),
          ),
        ],
      ),
    );
  }
}
