import 'package:auto_size_text/auto_size_text.dart';
import 'package:chuck_norris_tinder/chuck_norris_api/dio_fetcher.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chuck_norris_api/chuck_norris_api_model.dart';

class CardData {
  static int _colorIndex = 0;
  late final Color color;
  final ChuckNorrisAPIModel apiModel;

  CardData(this.apiModel) {
    color = Colors.primaries[_colorIndex++ % Colors.primaries.length];
  }
}

class Cards extends StatefulWidget {
  const Cards({Key? key}) : super(key: key);

  @override
  CardsState createState() => CardsState();
}

class CardsState extends State<Cards> {
  List<Widget> cardList = [];

  CardsState() {
    cardList.add(getLoadingCard());
    for (int i = cardList.length; i < 15; i++) {
      DioFetcher().getRandomJoke().then((joke) => _addCard(joke, 1));
    }
    cardList.add(getStartCard());
  }

  void _removeCard() {
    setState(() {
      cardList.removeAt(cardList.length - 1);
    });
    DioFetcher().getRandomJoke().then(
          (joke) => setState(() {
            _addCard(joke, 1);
          }),
        );
  }

  void _addCard(ChuckNorrisAPIModel apiModel, int pos) {
    var cardData = CardData(apiModel);

    var card = Card(
      color: cardData.color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 300,
        height: 400,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  textAlign: TextAlign.center,
                  cardData.apiModel.value,
                  style: const TextStyle(fontSize: 20),
                  maxLines: 12,
                ),
                IconButton(
                  icon: const Icon(Icons.open_in_browser),
                  tooltip: 'Open in browser',
                  onPressed: () {
                    _launchURL(cardData.apiModel.url);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

    cardList.insert(
      pos,
      Draggable(
        onDragEnd: (drag) => _removeCard(),
        childWhenDragging: Container(),
        feedback: card,
        child: card,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: cardList,
      ),
    );
  }

  Widget getStartCard() {
    var card = Card(
      elevation: 12,
      color: Colors.green,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const SizedBox(
        width: 300,
        height: 400,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Text(
              textScaleFactor: 1.5,
              textAlign: TextAlign.center,
              "Are you ready to see jokes about Chuck Norris?",
            ),
          ),
        ),
      ),
    );
    return Draggable(
      onDragEnd: (drag) => _removeCard(),
      childWhenDragging: Container(),
      feedback: card,
      child: card,
    );
  }

  Widget getLoadingCard() {
    var card = Card(
      elevation: 12,
      color: Colors.orange,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const SizedBox(
        width: 300,
        height: 400,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Text(
              textScaleFactor: 1.5,
              textAlign: TextAlign.center,
              "Loading...",
            ),
          ),
        ),
      ),
    );
    return card;
  }

  _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }
}
