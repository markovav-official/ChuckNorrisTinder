import 'package:chuck_norris_tinder/card.dart';
import 'package:chuck_norris_tinder/chuck_norris_api/dio_fetcher.dart';
import 'package:chuck_norris_tinder/test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'loading.dart';

class Cards extends StatefulWidget {
  const Cards({Key? key}) : super(key: key);

  @override
  CardsState createState() => CardsState();
}

class CardsState extends State<Cards> {
  static int _colorIndex = 0;
  List<Widget> cardList = [];
  Set<String> categories = {"All jokes"};
  String selectedCategory = "All jokes";

  Future<List<Widget>>? initFuture;

  @override
  Widget build(BuildContext context) {
    initFuture ??= _init();
    return Center(
      child: FutureBuilder<List<Widget>>(
        future: initFuture,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: snapshot.hasData && snapshot.data!.isNotEmpty
                    ? snapshot.data!
                    : [const Loading()],
              ),
              DropdownMenu(this, categories),
            ],
          );
        },
      ),
    );
  }

  void refreshAll() {
    setState(() {
      cardList.clear();
      initFuture = _init();
    });
  }

  void _removeCard() {
    setState(() {
      cardList.removeAt(cardList.length - 1);
    });
  }

  Future<List<Widget>> _init() async {
    await _fillCards();
    categories.addAll(await DioFetcher.getCategories());
    return cardList;
  }

  Future _fillCards() async {
    for (int i = 0; i < 5; i++) {
      await _addCard();
    }
  }

  Future _addCard() async {
    Color color = Colors.primaries[_colorIndex++ % Colors.primaries.length];
    CardWidget card;
    try {
      card =
          CardWidget(color, await DioFetcher.getRandomJoke(selectedCategory));
    } on DioError {
      if (!Navigator.of(context).canPop()) {
        _noConnectionDialog();
      }
      return;
    }
    cardList.insert(
      0,
      Draggable(
        onDragStarted: () => _fillCards(),
        onDragEnd: (drag) => _removeCard(),
        childWhenDragging: Container(),
        feedback: card,
        child: card,
      ),
    );
  }

  Future<void> _noConnectionDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No connection'),
          content: const SingleChildScrollView(
            child: Text("You don't have an internet connection!"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Try again'),
              onPressed: () {
                Navigator.of(context).pop();
                _fillCards().then((value) => setState(() {}));
              },
            ),
          ],
        );
      },
    );
  }
}
