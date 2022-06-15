import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chuck_norris_api/chuck_norris_joke.dart';

class CardWidget extends StatelessWidget {
  final ChuckNorrisJoke apiModel;
  final Color color;

  const CardWidget(this.color, this.apiModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    apiModel.color = color.value;
    return Card(
      color: color,
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
                  apiModel.value,
                  style: const TextStyle(fontSize: 20),
                  maxLines: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.open_in_browser),
                      tooltip: 'Open in browser',
                      onPressed: () {
                        _launchURL(apiModel.url);
                      },
                    ),
                    FavouriteButton(apiModel, key: key),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }
}

class FavouriteButton extends StatefulWidget {
  final ChuckNorrisJoke apiModel;

  const FavouriteButton(this.apiModel, {Key? key}) : super(key: key);

  @override
  FavouriteState createState() => FavouriteState();
}

class FavouriteState extends State<FavouriteButton> {
  static final collection = FirebaseFirestore.instance.collection("favourites");
  static final Set<String> favouritesCache = {};
  Future<bool>? _initFuture;

  @override
  Widget build(BuildContext context) {
    _initFuture = _init();
    return FutureBuilder(
      future: _initFuture,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (favouritesCache.contains(widget.apiModel.id)) {
          return IconButton(
            icon: const Icon(Icons.star),
            tooltip: 'Add to favourites',
            onPressed: () {
              collection.doc(widget.apiModel.id).delete();
              favouritesCache.remove(widget.apiModel.id);
              setState(() {});
            },
          );
        }
        return IconButton(
          icon: const Icon(Icons.star_outline),
          tooltip: 'Add to favourites',
          onPressed: () {
            collection.doc(widget.apiModel.id).set(widget.apiModel.toJson());
            favouritesCache.add(widget.apiModel.id);
            setState(() {});
          },
        );
      },
    );
  }

  Future<bool> _init() async {
    var doc = await collection.doc(widget.apiModel.id).get();
    if (!doc.exists && favouritesCache.contains(widget.apiModel.id)) {
      favouritesCache.remove(widget.apiModel.id);
    } else if (doc.exists && !favouritesCache.contains(widget.apiModel.id)) {
      favouritesCache.add(widget.apiModel.id);
    }
    return favouritesCache.contains(widget.apiModel.id);
  }
}
