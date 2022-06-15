import 'package:chuck_norris_tinder/favourites.dart';
import 'package:flutter/material.dart';

import 'cards.dart';

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
    SafeArea(
      child: Favourites(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: pages[currentIndex],
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
            label: 'Favourite',
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
